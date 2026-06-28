using FestApp.Models;
using Microsoft.EntityFrameworkCore;

namespace FestApp.Data
{
    public class FestAppContext : DbContext
    {
        public FestAppContext(DbContextOptions<FestAppContext> options)
            : base(options)
        {
        }
        public DbSet<User> Users { get; set; }
        public DbSet<Festival> Festivals { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<BookedLocation> BookedLocations { get; set; }
        public DbSet<FestivalEvent> FestivalEvents { get; set; }
        public DbSet<Review> Reviews { get; set; }
        public DbSet<ArtistApplication> ArtistApplications { get; set; }
    }
}
