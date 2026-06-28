using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("users")]
    public class User
    {
        [Key]
        [Column("user_id")]
        public int UserId { get; set; }

        [Column("full_name")]
        public string FullName { get; set; }
        [Column("email")]
        public string Email { get; set; } = string.Empty;

        [Column("password")]
        public string Password { get; set; } = string.Empty;

        [Column("phone")]
        public string? Phone { get; set; }

        [Column("role")]
        public string Role { get; set; }


        public List<ArtistApplication> ArtistApplications { get; set; } = new List<ArtistApplication>();
    }
}