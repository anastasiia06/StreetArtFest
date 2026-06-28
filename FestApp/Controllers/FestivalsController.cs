using FestApp.Data;
using FestApp.Models;               
using FestApp.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; 
using System.Linq;


namespace FestApp.Controllers
{
    public class FestivalsController : Controller
    {
        private readonly FestAppContext _context;

        public FestivalsController(FestAppContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var festivals = await _context.Festivals
               .OrderByDescending(a => a.Status.ToLower() == "активний")
                .ThenByDescending(a => a.Status.ToLower() == "заплановано")
                .ThenBy(a => a.Name)
        .ToListAsync();
            return View(festivals);
        }
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(Festival festival)
        {
            _context.Festivals.Add(festival);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
        public async Task<IActionResult> Details(int id)
        {
            var festival = await _context.Festivals
                .FirstOrDefaultAsync(f => f.FestivalId == id);

            if (festival == null)
                return NotFound();

            var role = HttpContext.Session.GetString("Role");
            ViewBag.Role = role;
            int? userId = HttpContext.Session.GetInt32("UserId");
            bool hasBooking = false;

           
            if (userId != null)
            {
                hasBooking = await _context.BookedLocations
                    .AnyAsync(bl => bl.FestivalId == id && bl.OrganizerId == userId.Value);
            }

           
            ViewBag.HasBooking = hasBooking;

            
            ViewBag.Events = await _context.FestivalEvents
                .Where(e => e.FestivalId == id)
                .Include(e => e.Location)
                .Include(e => e.Artist)
                .OrderBy(e => e.DatetimeStart)
                .ToListAsync();

            ViewBag.Locations = await _context.Locations
                .Where(l => l.Address.Contains(festival.City))
                .ToListAsync();

            ViewBag.Reviews = await _context.Reviews
                .Where(r => r.FestivalId == id)
                .Include(r => r.Visitor)
                .OrderByDescending(r => r.ReviewId)
                .ToListAsync();

            return View(festival);
        }
    }

}