using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FestApp.Models
{
    [Table("reviews")] 
    public class Review
    {
        [Key]
        [Column("review_id")]
        public int ReviewId { get; set; }

        [Column("rating")]
        public int Rating { get; set; }

        [Column("comment")]
        public string Comment { get; set; }

        [Column("visitor_id")]
        public int VisitorId { get; set; }

        [Column("festival_id")]
        public int FestivalId { get; set; }

        [ForeignKey("VisitorId")]
        public User Visitor { get; set; }
        [ForeignKey("FestivalId")]
        public Festival Festival { get; set; }

    }
}