using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLBanSach.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Index()
        {
            if(Session["taikhoan"] == null || Session["taikhoan"].ToString() == "")
                return RedirectToAction("Login");
            else
                return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
    }
}