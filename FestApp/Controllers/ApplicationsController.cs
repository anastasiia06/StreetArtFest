using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;

namespace FestApp.Controllers
{
    public class ApplicationsController : Controller
    {
        private readonly FestAppContext _context;

        public ApplicationsController(FestAppContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
         
            string role = HttpContext.Session.GetString("Role") ?? "Guest";
            int? userId = HttpContext.Session.GetInt32("UserId");

            if (role != "Організатор" || userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

           
            var myFestivalIds = await _context.BookedLocations
                .Where(bl => bl.OrganizerId == userId.Value) 
                .Select(bl => bl.FestivalId)
                .Distinct()
                .ToListAsync();
            var applications = await _context.ArtistApplications
                .Include(a => a.Artist)
                .Include(a => a.Festival)
                .Where(a => myFestivalIds.Contains(a.FestivalId)) 
                .OrderByDescending(a => a.Status.ToLower() == "очікує")
                .ToListAsync();

            return View(applications);
        }

        public IActionResult Create(int festivalId)
        {
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (role != "Aртист" && role != "Артист")
            {
                return RedirectToAction("Login", "Account");
            }

            ViewBag.FestivalId = festivalId;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(int festivalId, string artType, string comment)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (userId == null || (role != "Aртист" && role != "Артист"))
            {
                return RedirectToAction("Login", "Account");
            }

           
            bool alreadyExists = await _context.ArtistApplications
                .AnyAsync(a => a.ArtistId == userId.Value && a.FestivalId == festivalId);

            if (alreadyExists)
            {
                ViewBag.ErrorMessage = "Ви вже подали заявку на цей фестиваль!";
                ViewBag.FestivalId = festivalId;
                return View();
            }

          
            ArtistApplication app = new ArtistApplication
            {
                FestivalId = festivalId,
                ArtistId = userId.Value,
                ArtType = artType,
                Comment = comment,
                Status = "Очікує"
            };

           
            _context.ArtistApplications.Add(app);
            await _context.SaveChangesAsync();

            return RedirectToAction("Success", new { festivalId = app.FestivalId });
        }

        // Підтвердити заявку
        public async Task<IActionResult> Approve(int id)
        {
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (role != "Організатор")
                return RedirectToAction("Login", "Account");

            var app = await _context.ArtistApplications.FirstOrDefaultAsync(a => a.ApplicationId == id);

            if (app == null)
                return NotFound();

            app.Status = "Прийнято";
            await _context.SaveChangesAsync();

            return RedirectToAction("Index");
        }

        // Відхилити заявку
        public async Task<IActionResult> Reject(int id)
        {
            string role = HttpContext.Session.GetString("Role") ?? "Guest";

            if (role != "Організатор")
                return RedirectToAction("Login", "Account");

            var app = await _context.ArtistApplications.FirstOrDefaultAsync(a => a.ApplicationId == id);

            if (app == null)
                return NotFound();

            app.Status = "Відхилено";
            await _context.SaveChangesAsync();

            return RedirectToAction("Index");
        }

       
        public IActionResult Success(int festivalId)
        {
            var festival = _context.Festivals.FirstOrDefault(f => f.FestivalId == festivalId);

            if (festival == null)
                return NotFound();

            ViewBag.FestivalName = festival.Name;
            ViewBag.FestivalDate = festival.StartDate.ToString("dd.MM.yyyy");

            return View();
        }
    }
}