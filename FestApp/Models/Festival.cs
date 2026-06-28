using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("festivals")]
    public class Festival
    {
        [Key]
        [Column("festival_id")]
        public int FestivalId { get; set; }

        [Column("name")]
        public string Name { get; set; }

        [Column("city")]
        public string City { get; set; }

        [Column("start_date")]
        public DateTime StartDate { get; set; }

        [Column("end_date")]
        public DateTime EndDate { get; set; }

        [Column("status")]
        public string Status { get; set; }

        [Column("description")]
        public string Description { get; set; }

        [Column("price")]
        public decimal Price { get; set; }

        [Column("admin_id")]
        public int AdminId { get; set; }
        public List<Review> Reviews { get; set; }
        public List<FestivalEvent> FestivalEvents { get; set; }
        public List<ArtistApplication> ArtistApplications { get; set; }
        public List<BookedLocation> BookedLocations { get; set; }
    }
}