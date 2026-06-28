using FestApp.Data;
using FestApp.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FestApp.Controllers
{
    public class AccountController : Controller
    {
        private readonly FestAppContext _context;

        public AccountController(FestAppContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string email, string password)
        {
            var user = _context.Users
                .FirstOrDefault(u => u.Email == email && u.Password == password);

            if (user == null)
            {
                ViewBag.Error = "Невірний email або пароль!";
                return View();
            }

            HttpContext.Session.SetInt32("UserId", user.UserId);
            HttpContext.Session.SetString("Role", user.Role);
            HttpContext.Session.SetString("FullName", user.FullName);

            if (user.Role == "Адміністратор")
            {
                return RedirectToAction("Index", "Admin");
            }

            
            return RedirectToAction("Index", "Profile");
        }
        [HttpGet]
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(string fullName, string email, string password, string phone, string role)
        {
            var exists = _context.Users.Any(u => u.Email == email);

            if (exists)
            {
                ViewBag.Error = "Користувач з таким email вже існує!";
                return View();
            }

            User user = new User
            {
                FullName = fullName,
                Email = email,
                Password = password,
                Phone = phone,
                Role = role
            };

            _context.Users.Add(user);
            _context.SaveChanges();
            HttpContext.Session.SetInt32("UserId", user.UserId);
            HttpContext.Session.SetString("Role", user.Role);
            HttpContext.Session.SetString("FullName", user.FullName);
            return RedirectToAction("Index", "Home");
        }
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login");
        }

        
    }
}