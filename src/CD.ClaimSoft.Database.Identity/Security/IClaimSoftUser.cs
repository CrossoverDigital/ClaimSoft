namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <summary>
    /// Minimal interface for a <see cref="IClaimSoftUser{TKey, TTenant}"/> with a <see cref="string"/> user
    /// <see cref="IUser.Id"/> and <see cref="IClaimSoftUser{TKey,TTenant}.TenantId"/>.
    /// </summary>
    public interface IClaimSoftUser : IClaimSoftUser<string, string>
    {
    }
}
