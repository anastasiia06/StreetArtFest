using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("festival_events")]
    public class FestivalEvent
    {
        [Key]
        [Column("event_id")]
        public int EventId { get; set; }

        public string Title { get; set; }
        [Column("datetime_start")]
        public DateTime DatetimeStart { get; set; }
        [Column("datetime_end")]
        public DateTime DatetimeEnd { get; set; }
        [Column("festival_id")]

        public int FestivalId { get; set; }
        [Column("location_id")]
        public int LocationId { get; set; }
        [Column("artist_id")]
        public int? ArtistId { get; set; }

    
        [ForeignKey("FestivalId")]
        public Festival Festival { get; set; }

        [ForeignKey("LocationId")]
        public Location Location { get; set; }

        [ForeignKey("ArtistId")]
        public User Artist { get; set; }

    }
}