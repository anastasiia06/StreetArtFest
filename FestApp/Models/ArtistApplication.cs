using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("artist_applications")]
    public class ArtistApplication
    {
        [Key]
        [Column("application_id")] 
        public int ApplicationId { get; set; }

        [Column("art_type")] 
        public string ArtType { get; set; }

        [Column("comment")]
        public string Comment { get; set; }

        [Column("status")]
        public string Status { get; set; }

        [Column("festival_id")]
        public int FestivalId { get; set; }

        [Column("artist_id")]
        public int ArtistId { get; set; }

        public Festival Festival { get; set; }
        public User Artist { get; set; }
    }
}