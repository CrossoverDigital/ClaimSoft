using System.Data.Entity;
using CD.ClaimSoft.Application.Models;

namespace CD.ClaimSoft.Database
{
    public class MovieDBContext : DbContext
    {
        public DbSet<Movie> Movies { get; set; }
    }
}