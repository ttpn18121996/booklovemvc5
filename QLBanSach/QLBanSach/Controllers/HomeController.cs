using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLBanSach.Models;

namespace QLBanSach.Controllers
{
    public class HomeController : Controller
    {

        //Tạo đối tượng chứa toàn bộ CSDL từ dbQLBansach
        dbQLBansachDataContext data = new dbQLBansachDataContext();

        //Lấy danh sách sản phẩm theo số lượng
        private List<SACH> LaySachMoi(int count)
        {
            //Sắp xếp giảm dần theo ngày cập nhật
            return data.SACHes.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }

        public ActionResult Index()
        {
            var sachmoi = LaySachMoi(4);
            return View(sachmoi);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        
    }
}