using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;

namespace FestApp.Models
{
    [Table("locations")] 
    public class Location
    {
        [Key]
        [Column("location_id")]
        public int LocationId { get; set; }

        [Column("name")]
        public string Name { get; set; }

        [Column("address")]
        public string Address { get; set; }

        [Column("price_location")] 
        public decimal PriceLocation { get; set; }

        public List<BookedLocation> BookedLocations { get; set; } = new List<BookedLocation>();
        public List<FestivalEvent> FestivalEvents { get; set; } = new List<FestivalEvent>();
    }
}