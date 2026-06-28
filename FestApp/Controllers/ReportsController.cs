using FestApp.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FestApp.Controllers
{
    public class ReportsController : Controller
    {
        private readonly FestAppContext _context;

        public ReportsController(FestAppContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (role != "Адміністратор")
                return RedirectToAction("Login", "Account");

            return View();
        }

        public IActionResult FestivalsByStatus()
        {
            var data = _context.Festivals
                .GroupBy(f => f.Status)
                .Select(g => new
                {
                    Status = g.Key,
                    Count = g.Count()
                })
                .ToList();

            return Json(data);
        }

        public IActionResult FestivalsWithoutReviews()
        {
            var data = _context.Festivals
                .Where(f => !_context.Reviews.Any(r => r.FestivalId == f.FestivalId))
                .Select(f => new
                {
                    f.FestivalId,
                    f.Name,
                    f.City
                })
                .ToList();

            return Json(data);
        }

        public IActionResult AverageRatings()
        {
            var data = _context.Festivals
                .Select(f => new
                {
                    f.Name,
                    AvgRating = _context.Reviews
                        .Where(r => r.FestivalId == f.FestivalId)
                        .Average(r => (double?)r.Rating) ?? 0
                })
                .ToList();

            return Json(data);
        }
    
        public IActionResult TopFestivals()
        {
            var data = _context.Festivals
                .Select(f => new
                {
                    f.Name,
                    ApplicationsCount = _context.ArtistApplications.Count(a => a.FestivalId == f.FestivalId)
                })
                .OrderByDescending(f => f.ApplicationsCount)
                .Take(3)
                .ToList();

            return Json(data);
        }

 
        public IActionResult UsersByRole()
        {
            var data = _context.Users
                .GroupBy(u => u.Role)
                .Select(g => new
                {
                    Role = g.Key,
                    Count = g.Count()
                })
                .ToList();

            return Json(data);
        }

       
        public IActionResult FestivalsByCity()
        {
            var data = _context.Festivals
                .GroupBy(f => f.City)
                .Select(g => new
                {
                    City = g.Key,
                    Count = g.Count()
                })
                .OrderByDescending(g => g.Count)
                .ToList();

            return Json(data);
        }
    }
}