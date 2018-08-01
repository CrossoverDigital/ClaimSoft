using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;

using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <inheritdoc />
    /// <summary>
    /// Identity <see cref="T:System.Data.Entity.DbContext" /> for multi tenant user accounts.
    /// </summary>
    /// <typeparam name="TUser">The type of user.</typeparam>
    /// <typeparam name="TRole">The type of role.</typeparam>
    /// <typeparam name="TKey">The type of <see cref="!:IUser{TKey}.Id" /> for a user.</typeparam>
    /// <typeparam name="TTenantKey">The type of <see cref="!:IMultiTenantUser{TKey, TTenantKey}.TenantId" /> for a user.</typeparam>
    /// <typeparam name="TUserLogin">The type of user login.</typeparam>
    /// <typeparam name="TUserRole">The type of user role.</typeparam>
    /// <typeparam name="TUserClaim">The type of user claim.</typeparam>
    public class ClaimSoftIdentityDbContext<TUser, TRole, TKey, TTenantKey, TUserLogin, TUserRole, TUserClaim>
        : IdentityDbContext<TUser, TRole, TKey, TUserLogin, TUserRole, TUserClaim>
        where TUser : ClaimSoftIdentityUser<TKey, TTenantKey, TUserLogin, TUserRole, TUserClaim>
        where TRole : IdentityRole<TKey, TUserRole>
        where TUserLogin : ClaimSoftIdentityUserLogin<TKey, TTenantKey>, new()
        where TUserRole : IdentityUserRole<TKey>, new()
        where TUserClaim : IdentityUserClaim<TKey>, new()
    {
        /// <inheritdoc />
        /// <summary>
        /// Initializes a new instance of the <see cref="T:CD.ClaimSoft.Application.Security.MultitenantIdentityDbContext`7" /> class.
        /// </summary>
        public ClaimSoftIdentityDbContext()
            : this("DefaultConnection")
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// Initializes a new instance of the <see cref="T:CD.ClaimSoft.Application.Security.MultitenantIdentityDbContext`7" /> class.
        /// </summary>
        /// <param name="nameOrConnectionString">Either the database name or a connection string. </param>
        public ClaimSoftIdentityDbContext(string nameOrConnectionString)
            : base(nameOrConnectionString)
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// Performs custom validation.
        /// </summary>
        /// <param name="entityEntry"><see cref="T:System.Data.Entity.Infrastructure.DbEntityEntry" /> instance to be validated. </param>
        /// <param name="items">User-defined dictionary containing additional info for custom validation. It will be
        /// passed to ValidationContext and will be exposed as ValidationContext.Items.
        /// This parameter is optional and can be null.
        /// </param>
        /// <returns>Entity validation result. Possibly null when overridden.</returns>
        protected override DbEntityValidationResult ValidateEntity(
            DbEntityEntry entityEntry,
            IDictionary<object, object> items)
        {
            if (entityEntry != null && entityEntry.State == EntityState.Added)
            {
                if (entityEntry.Entity is TUser user)
                {
                    // TODO Perform Custom Validation.
                    return new DbEntityValidationResult(entityEntry, Enumerable.Empty<DbValidationError>());
                }
            }

            return base.ValidateEntity(entityEntry, items);
        }
        
        ///// <summary>
        ///// Applies custom model definitions for multi-tenancy.
        ///// </summary>
        ///// <param name="modelBuilder">The builder that defines the model for the context being created. </param>
        //protected override void OnModelCreating(DbModelBuilder modelBuilder)
        //{
        //    base.OnModelCreating(modelBuilder);

        //    modelBuilder.Entity<TUserLogin>()
        //        .HasKey(e => new { e.TenantId, e.LoginProvider, e.ProviderKey, e.UserId });

        //    modelBuilder.Entity<TUser>()
        //        .Property(u => u.UserName)
        //        .HasColumnAnnotation(
        //            "Index",
        //            new IndexAnnotation(new IndexAttribute("UserNameIndex", order: 1)
        //            {
        //                IsUnique = true
        //            }));
        //}
    }
}
