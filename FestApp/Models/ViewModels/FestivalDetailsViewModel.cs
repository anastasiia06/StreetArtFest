using FestApp.Models;

namespace FestApp.Models.ViewModels
{
    public class FestivalDetailsViewModel
    {
        public Festival Festival { get; set; }
        public List<Review> Reviews { get; set; }
    }
}