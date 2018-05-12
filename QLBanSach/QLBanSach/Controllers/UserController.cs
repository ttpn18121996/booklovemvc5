using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLBanSach.Models;

namespace QLBanSach.Controllers
{
    public class UserController : Controller
    {
        dbQLBansachDataContext data = new dbQLBansachDataContext();
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Signup()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Signup(FormCollection collection, KHACHHANG kh)
        {
            var Hoten = collection["HotenKH"];
            var TenDN = collection["TenDN"];
            var Matkhau = collection["Matkhau"];
            var Matkhaunhaplai = collection["Matkhaunhaplai"];
            var Diachi = collection["Diachi"];
            var Email = collection["Email"];
            var Dienthoai = collection["Dienthoai"];
            var Ngaysinh = String.Format("{0:dd/MM/yyyy}", collection["Ngaysinh"]);
            if (String.IsNullOrEmpty(Hoten))
            {
                ViewData["Loi1"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(TenDN))
            {
                ViewData["Loi2"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(Matkhau))
            {
                ViewData["Loi3"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(Matkhaunhaplai))
            {
                ViewData["Loi4"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(Email))
            {
                ViewData["Loi5"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(Diachi))
            {
                ViewData["Loi6"] = "Không được bỏ trống ô này";
            }
            else if (String.IsNullOrEmpty(Dienthoai))
            {
                ViewData["Loi7"] = "Không được bỏ trống ô này";
            }
            else
            {
                kh.HoTen = Hoten;
                kh.Taikhoan = TenDN;
                kh.Matkhau = Matkhau;
                kh.Email = Email;
                kh.DiachiKH = Diachi;
                kh.DienthoaiKH = Dienthoai;
                kh.Ngaysinh = DateTime.Parse(Ngaysinh);
                data.KHACHHANGs.InsertOnSubmit(kh);
                data.SubmitChanges();
                return RedirectToAction("Signin");
            }
            return this.Signup();
        }

        [HttpGet]
        public ActionResult Signin()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Signin(FormCollection collection)
        {
            var TenDN = collection["TenDN"];
            var Matkhau = collection["Matkhau"];
            ViewBag.Error = "0";
            if(String.IsNullOrEmpty(TenDN))
            {
                ViewData["loi1"] = "Không được bỏ trống";
            }
            else if(String.IsNullOrEmpty(Matkhau))
            {
                ViewData["loi2"] = "Không được bỏ trống";
            }
            else
            {
                KHACHHANG kh = data.KHACHHANGs.SingleOrDefault(n => n.Taikhoan == TenDN && n.Matkhau == Matkhau);
                if(kh!=null)
                {
                    Session["Taikhoan"] = kh;
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Error = "1";
                    ViewBag.Thongbao = "Lỗi! Đăng nhập thất bại";
                }
            }
            return View();
        }
        [HttpGet]
        public ActionResult Signout()
        {
            Session["Taikhoan"] = null;
            return RedirectToAction("Index","Home");
        }
	}
}