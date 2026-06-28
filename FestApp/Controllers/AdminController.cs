using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http;

namespace FestApp.Controllers
{
    public class AdminController : Controller
    {
        private readonly FestAppContext _context;

        public AdminController(FestAppContext context)
        {
            _context = context;
        }

        private bool IsAdmin()
        {
            string role = HttpContext.Session.GetString("Role") ?? "Guest";
            return role == "Адміністратор";
        }

        public IActionResult Index()
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            return View();
        }

        //  FESTIVALS  

        public async Task<IActionResult> Festivals()
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            var festivals = await _context.Festivals.ToListAsync();
            return View(festivals);
        }

        public IActionResult CreateFestival()
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CreateFestival(Festival festival)
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            if (!ModelState.IsValid)
                return View(festival);

            _context.Festivals.Add(festival);
            await _context.SaveChangesAsync();

            return RedirectToAction("Festivals");
        }

        //  LOCATIONS

        public async Task<IActionResult> Locations()
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            var locations = await _context.Locations.ToListAsync();
            return View(locations);
        }

        public IActionResult CreateLocation()
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CreateLocation(Location location)
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            if (!ModelState.IsValid)
                return View(location);

            _context.Locations.Add(location);
            await _context.SaveChangesAsync();

            return RedirectToAction("Locations");
        }
        [HttpPost]
        public async Task<IActionResult> DeleteLocation(int id)
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            var location = await _context.Locations.FindAsync(id);
            if (location != null)
            {
                _context.Locations.Remove(location);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction("Locations");
        }
        [HttpPost]
        public async Task<IActionResult> DeleteFestival(int id)
        {
            if (!IsAdmin())
                return RedirectToAction("Login", "Account");

            var festival = await _context.Festivals.FindAsync(id);
            if (festival != null)
            {
                _context.Festivals.Remove(festival);
                await _context.SaveChangesAsync(); 
            }

            return RedirectToAction("Festivals");
        }
    }
}