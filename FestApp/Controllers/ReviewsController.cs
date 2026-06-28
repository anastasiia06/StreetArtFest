using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace FestApp.Controllers
{
    public class ReviewsController : Controller
    {
        private readonly FestAppContext _context;

        public ReviewsController(FestAppContext context)
        {
            _context = context;
        }

        [HttpPost]
        public IActionResult Create(int FestivalId, int Rating, string Comment)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (userId == null || role != "Відвідувач")
            {
                return RedirectToAction("Login", "Account");
            }

            Review review = new Review
            {
                Rating = Rating,
                Comment = Comment,
                VisitorId = userId.Value,
                FestivalId = FestivalId
            };

            _context.Reviews.Add(review);
            _context.SaveChanges();

            return RedirectToAction("Details", "Festivals", new { id = FestivalId });
        }
    }
}