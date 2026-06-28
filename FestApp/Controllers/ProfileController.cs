using FestApp.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http; 

namespace FestApp.Controllers
{
    public class ProfileController : Controller
    {
        private readonly FestAppContext _context;

        public ProfileController(FestAppContext context)
        {
            _context = context;
        }

       
        public async Task<IActionResult> Index()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            
            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);

            if (user == null)
            {
                return RedirectToAction("Login", "Account");
            }

            if (role == "Відвідувач")
            {
                ViewBag.Reviews = await _context.Reviews
                    .Where(r => r.VisitorId == userId)
                    .Include(r => r.Festival)
                    .ToListAsync();
            }
            else if (role == "Артист")
            {
                ViewBag.Applications = await _context.ArtistApplications
                    .Where(a => a.ArtistId == userId)
                    .Include(a => a.Festival)
                    .ToListAsync();
            }
            else if (role == "Організатор")
            {
                ViewBag.Bookings = await _context.BookedLocations
                    .Where(b => b.OrganizerId == userId)
                    .Include(b => b.Festival)
                    .Include(b => b.Location)
                    .ToListAsync();
            }

            return View(user);
        }
    }
}