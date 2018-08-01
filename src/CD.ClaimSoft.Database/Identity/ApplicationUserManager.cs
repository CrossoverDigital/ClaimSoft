using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using CD.ClaimSoft.Common.Identity.Service;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.DataProtection;

namespace CD.ClaimSoft.Database.Identity
{
    public sealed class ApplicationUserManager : UserManager<ApplicationUser>
    {
        #region Instance Variables

        /// <summary>
        /// The database context.
        /// </summary>
        readonly IClaimSoftContext _dbContext;

        /// <summary>
        /// The log service.
        /// </summary>
        readonly ILogService<ApplicationUserManager> _logService;

        /// <summary>
        /// The cache.
        /// </summary>
        readonly IRedisCache _cache;

        /// <summary>
        /// The password history limit
        /// </summary>
        private const int PasswordHistoryLimit = 3;

        /// <summary>
        /// The data protection provider.
        /// </summary>
        private IDataProtectionProvider _dataProtectionProvider;

        #endregion

        public ApplicationUserManager(IUserStore<ApplicationUser> store, IDataProtectionProvider dataProtectionProvider, IClaimSoftContext db, IRedisCache cache, ILogService<ApplicationUserManager> logService)
            : base(store)
        {
            _dbContext = db;
            _logService = logService;
            _cache = cache;
            _dataProtectionProvider = dataProtectionProvider;

            UserValidator = new UserValidator<ApplicationUser>(this)
            {
                AllowOnlyAlphanumericUserNames = false,
                RequireUniqueEmail = true
            };

            // Configure validation logic for passwords
            PasswordValidator = new PasswordValidator
            {
                RequiredLength = 8,
                RequireNonLetterOrDigit = false,
                RequireDigit = true,
                RequireLowercase = true,
                RequireUppercase = true,
            };

            // Configure user lockout defaults
            UserLockoutEnabledByDefault = false;
            //DefaultAccountLockoutTimeSpan = TimeSpan.FromMinutes(5);
            //MaxFailedAccessAttemptsBeforeLockout = 5;

            // Register two factor authentication providers. This application uses Phone and Emails as a step of receiving a code for verifying the user
            // You can write your own provider and plug it in here.
            RegisterTwoFactorProvider("Phone Code", new PhoneNumberTokenProvider<ApplicationUser>
            {
                MessageFormat = "Your security code is {0}"
            });

            RegisterTwoFactorProvider("Email Code", new EmailTokenProvider<ApplicationUser>
            {
                Subject = "Security Code",
                BodyFormat = "Your security code is {0}"
            });

            EmailService = new EmailService();
            SmsService = new SmsService();

            UserTokenProvider = new DataProtectorTokenProvider<ApplicationUser>(dataProtectionProvider.Create("ASP.NET Id"));
        }

        #region Agency Methods

        /// <summary>
        /// Gets the user's agencies.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>
        /// The list of agencies the user has.
        /// </returns>
        /// <inheritdoc />
        public List<Agency> UserAgencies(string userId)
        {
            try
            {



                var userAgencies = _dbContext.AgencyUsers.Where(au => au.AspNetUserId == userId).Select(au => au.AgencyId).ToList();
                return _dbContext.Agencies.Where(a => userAgencies.Contains(a.Id)).ToList().Select(a => new Agency
                {
                    AgencyId = a.Id,
                    AgencyName = a.AgencyName,
                    AgencyNumber = a.AgencyNumber
                }).ToList();
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        #endregion

        public override async Task<IdentityResult> ChangePasswordAsync(string userId, string currentPassword, string newPassword)
        {
            if (await IsPasswordHistory(userId, newPassword))
                return await Task.FromResult(IdentityResult.Failed("Cannot reuse old password"));

            var result = await base.ChangePasswordAsync(userId, currentPassword, newPassword);

            if (!result.Succeeded)
                return result;

            var user = await FindByIdAsync(userId);

            user.PasswordHistory.Add(new PasswordHistory() { UserId = user.Id, PasswordHash = PasswordHasher.HashPassword(newPassword) });

            return await UpdateAsync(user);
        }

        /// <summary>
        /// Reset a user's password using a reset password token
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="token"></param>
        /// <param name="newPassword"></param>
        /// <returns></returns>
        public override async Task<IdentityResult> ResetPasswordAsync(string userId, string token, string newPassword)
        {
            if (await IsPasswordHistory(userId, newPassword))
                return await Task.FromResult(IdentityResult.Failed("Cannot reuse old password"));

            var result = await base.ResetPasswordAsync(userId, token, newPassword);

            if (!result.Succeeded) return result;

            var user = await FindByIdAsync(userId);

            user.PasswordHistory.Add(new PasswordHistory() { UserId = user.Id, PasswordHash = PasswordHasher.HashPassword(newPassword) });

            return await UpdateAsync(user);
        }

        private async Task<bool> IsPasswordHistory(string userId, string newPassword)
        {
            var user = await FindByIdAsync(userId);

            return user.PasswordHistory.OrderByDescending(o => o.CreatedDate)
                .Select(s => s.PasswordHash)
                .Take(PasswordHistoryLimit).Any(w => PasswordHasher.VerifyHashedPassword(w, newPassword) != PasswordVerificationResult.Failed);
        }

        public Task AddToPasswordHistoryAsync(ApplicationUser user, string password)
        {
            user.PasswordHistory.Add(new PasswordHistory() { UserId = user.Id, PasswordHash = password });
            return UpdateAsync(user);
        }

        public static ApplicationUserManager Create(IdentityFactoryOptions<ApplicationUserManager> options, IOwinContext context)
        {
            var manager = new ApplicationUserManager(new UserStore<ApplicationUser>(context.Get<ClaimSoftContext>()), new DpapiDataProtectionProvider(), new ClaimSoftContext(), new RedisCache(), new LogService<ApplicationUserManager>());
            // Configure validation logic for usernames
            manager.UserValidator = new UserValidator<ApplicationUser>(manager)
            {
                AllowOnlyAlphanumericUserNames = false,
                RequireUniqueEmail = true
            };

            // Configure validation logic for passwords
            manager.PasswordValidator = new PasswordValidator
            {
                RequiredLength = 10,
                RequireNonLetterOrDigit = true,
                RequireDigit = true,
                RequireLowercase = false,
                RequireUppercase = false,

            };

            // Configure user lockout defaults
            manager.UserLockoutEnabledByDefault = true;
            manager.DefaultAccountLockoutTimeSpan = TimeSpan.FromMinutes(5);
            manager.MaxFailedAccessAttemptsBeforeLockout = 5;

            // Register two factor authentication providers. This application uses Phone and Emails as a step of receiving a code for verifying the user
            // You can write your own provider and plug it in here.
            manager.RegisterTwoFactorProvider("Phone Code", new PhoneNumberTokenProvider<ApplicationUser>
            {
                MessageFormat = "Your security code is {0}"
            });
            manager.RegisterTwoFactorProvider("Email Code", new EmailTokenProvider<ApplicationUser>
            {
                Subject = "Security Code",
                BodyFormat = "Your security code is {0}"
            });

            manager.EmailService = new EmailService();
            manager.SmsService = new SmsService();

            var dataProtectionProvider = options.DataProtectionProvider;

            if (dataProtectionProvider != null)
            {
                manager.UserTokenProvider = new DataProtectorTokenProvider<ApplicationUser>(dataProtectionProvider.Create("ASP.NET Id"));
            }

            return manager;
        }
    }
}
