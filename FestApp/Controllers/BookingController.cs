using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace FestApp.Controllers
{
    public class BookingController : Controller
    {
        private readonly FestAppContext _context;

        public BookingController(FestAppContext context)
        {
            _context = context;
        }

        [HttpGet]
        [HttpGet]
        [HttpGet]
        public IActionResult Create(int festivalId, int locationId)
        {
            

            ViewBag.FestivalId = festivalId;
            ViewBag.LocationId = locationId;
            return View();
        }

        [HttpPost]

        [HttpPost]
        [HttpPost]
        public IActionResult Create(BookedLocation booking)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null) return RedirectToAction("Login", "Account");

            booking.OrganizerId = userId.Value;

            try
            {
               
                _context.BookedLocations.Add(booking);
                _context.SaveChanges();

                return RedirectToAction("Details", "Festivals", new { id = booking.FestivalId });
            }
            catch (Exception)
            {
               
                TempData["Error"] = "❌ Ця локація вже заброньована на вибраний час!";
                return RedirectToAction("Details", "Festivals", new { id = booking.FestivalId });
            }
        }
        [HttpGet]
        public IActionResult CheckAvailability(int locationId, DateTime start, DateTime end)
        {
            bool isBusy = _context.BookedLocations.Any(bl =>
                bl.LocationId == locationId &&
                start < bl.DatetimeEnd &&
                end > bl.DatetimeStart);

            return Json(new { isBusy = isBusy });
        }
    }
}