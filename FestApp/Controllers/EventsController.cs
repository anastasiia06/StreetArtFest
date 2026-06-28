using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FestApp.Controllers
{
    public class EventsController : Controller
    {
        private readonly FestAppContext _context;

        public EventsController(FestAppContext context)
        {
            _context = context;
        }

     
        public IActionResult Index(int festivalId)
        {
            var eventsList = _context.FestivalEvents
            .Include(e => e.Festival)
             .Include(e => e.Location)
                 .Where(e => e.FestivalId == festivalId)
                .ToList();

            ViewBag.FestivalId = festivalId;

            return View(eventsList);
        }



        public IActionResult Create(int festivalId)
        {
            ViewBag.FestivalId = festivalId;
           
            ViewBag.Artists = _context.Users.Where(u => u.Role == "Артист").ToList();

            ViewBag.Locations = _context.BookedLocations
                .Where(bl => bl.FestivalId == festivalId)
                .Select(bl => bl.Location)
                .Distinct()
                .ToList();

            return View();

        }


        [HttpPost]
        public IActionResult Create(FestivalEvent ev)
        {
            _context.FestivalEvents.Add(ev);

            _context.SaveChanges();

            return RedirectToAction("Index", new { festivalId = ev.FestivalId });

        }

        public IActionResult Edit(int id)
        {
            var ev = _context.FestivalEvents.Find(id);

            if (ev == null)
                return NotFound();

            ViewBag.Locations = _context.BookedLocations
            .Where(bl => bl.FestivalId == ev.FestivalId)
            .Select(bl => bl.Location)
            .Distinct()
            .ToList();

            return View(ev);
        }

        
        [HttpPost]
        public IActionResult Edit(FestivalEvent ev)
        {
            _context.FestivalEvents.Update(ev);
            _context.SaveChanges();

            return RedirectToAction("Index", new { festivalId = ev.FestivalId });
        }

        public IActionResult Delete(int id)
        {
            var ev = _context.FestivalEvents.Find(id);

            if (ev != null)
            {
                int festId = ev.FestivalId;

                _context.FestivalEvents.Remove(ev);
                _context.SaveChanges();

                return RedirectToAction("Index", new { festivalId = festId });
            }

            return NotFound();
        }
    }
}