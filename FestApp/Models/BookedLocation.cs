using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("booked_locations")]
    public class BookedLocation
    {
        [Key]
        [Column("booked_locations_id")]
        public int BookedLocationsId { get; set; }

        [Column("datetime_start")]
        public DateTime DatetimeStart { get; set; }

        [Column("datetime_end")]
        public DateTime DatetimeEnd { get; set; }

        [Column("organizer_id")]
        public int OrganizerId { get; set; }

        [Column("festival_id")]
        public int FestivalId { get; set; }

        [Column("location_id")]
        public int LocationId { get; set; }

        public Location Location { get; set; }
        public User Organizer { get; set; }

        [ForeignKey("FestivalId")]
        public Festival Festival { get; set; }
    }
}