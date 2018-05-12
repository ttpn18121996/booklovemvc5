using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLBanSach.Models;

namespace QLBanSach.Controllers
{
    public class CartController : Controller
    {
        dbQLBansachDataContext data = new dbQLBansachDataContext();
        // GET: Cart
        public ActionResult Index()
        {
            List<CartViewModel> lstGiohang = Laygiohang();
            if(lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();
            return View(lstGiohang);
        }

        public List<CartViewModel> Laygiohang()
        {
            List<CartViewModel> lstGiohang = Session["Giohang"] as List<CartViewModel>;
            if(lstGiohang == null)
            {
                lstGiohang = new List<CartViewModel>();
                Session["Giohang"] = lstGiohang;
            }
            return lstGiohang;
        }

        public ActionResult Themgiohang(int iMasach, string strURL)
        {
            //Lấy ra session giỏ hàng
            List<CartViewModel> lstGiohang = Laygiohang();
            //Kiểm tra sách tồn tại trong Session["Giohang"] chưa
            CartViewModel sanpham = lstGiohang.Find(n => n.iMasach == iMasach);
            if(sanpham == null)
            {
                sanpham = new CartViewModel(iMasach);
                lstGiohang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.iSoluong ++;
                return Redirect(strURL);
            }
        }

        //Tổng số lượng
        private int TongSoLuong()
        {
            int iTongSoLuong = 0;
            List<CartViewModel> lstGiohang = Session["Giohang"] as List<CartViewModel>;
            if(lstGiohang != null)
            {
                iTongSoLuong = lstGiohang.Sum(n => n.iSoluong);
            }
            return iTongSoLuong;
        }

        //Tính tổng tiền
        private double TongTien()
        {
            double iTongTien = 0;
            List<CartViewModel> lstGiohang = Session["Giohang"] as List<CartViewModel>;
            if(lstGiohang != null)
            {
                iTongTien = lstGiohang.Sum(n => n.dThanhtien);
            }
            return iTongTien;
        }

        //Sửa giỏ hàng
        public ActionResult SuaGiohang()
        {
            if(Session["Giohang"]==null)
            {
                return RedirectToAction("Index", "Home");
            }
            List<CartViewModel> lstGiohang = Laygiohang();
            return View(lstGiohang);
        }

        //Cập nhật giỏ hàng
        public ActionResult Capnhatgiohang(int iMaSP, FormCollection f)
        {
            SACH sach = data.SACHes.SingleOrDefault(n => n.Masach == iMaSP);
            if(sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //Lấy giỏ hàng từ session
            List<CartViewModel> lstGiohang = Laygiohang();

            CartViewModel sanpham = lstGiohang.SingleOrDefault(n => n.iMasach == iMaSP);
            if(sanpham != null)
            {
                sanpham.iSoluong = int.Parse(f["txtSoluong"].ToString());
            }
            return RedirectToAction("Index");
        }

        //Xoá giỏ hàng
        public ActionResult XoaGiohang(int iMaSP)
        {
            //Lấy giỏ hàng từ session
            List<CartViewModel> lstGiohang = Laygiohang();
            //Kiểm tra sách đã có trong session
            CartViewModel sanpham = lstGiohang.Single(n => n.iMasach == iMaSP);
            //Nếu tồn tại thì cho sửa số lượng
            if(sanpham != null)
            {
                lstGiohang.RemoveAll(n => n.iMasach == iMaSP);
                return RedirectToAction("Index");
            }
            if(lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult Order()
        {
            //Kiểm tra đăng nhập
            if(Session["Taikhoan"] == null || Session["Taikhoan"].ToString() == "")
            {
                return RedirectToAction("Signin", "User");
            }
            if(Session["Giohang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }

            //Lấy giỏ hàng từ session
            List<CartViewModel> lstGiohang = Laygiohang();
            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongTien = TongTien();

            return View(lstGiohang);
        }

        [HttpPost]
        public ActionResult Order(FormCollection collection)
        {
            DONDATHANG ddh = new DONDATHANG();
            KHACHHANG kh = (KHACHHANG)Session["Taikhoan"];
            List<CartViewModel> gh = Laygiohang();

            ddh.MaKH = kh.MaKH;
            ddh.Ngaydat = DateTime.Now;
            var ngaygiao = String.Format("{0:dd/MM/yyyy}", collection["Ngaygiao"]);
            ddh.Ngaygiao = DateTime.Parse(ngaygiao);
            ddh.Tinhtranggiaohang = false;
            ddh.Dathanhtoan = false;
            data.DONDATHANGs.InsertOnSubmit(ddh);
            data.SubmitChanges();

            //Thêm chi tiết đơn hàng
            foreach(var item in gh)
            {
                CHITIETDONTHANG ctdh = new CHITIETDONTHANG();
                ctdh.MaDonHang = ddh.MaDonHang;
                ctdh.Masach = item.iMasach;
                ctdh.Soluong = item.iSoluong;
                ctdh.Dongia = (decimal)item.dDongia;
                data.CHITIETDONTHANGs.InsertOnSubmit(ctdh);
            }
            data.SubmitChanges();
            Session["Giohang"] = null;
            return RedirectToAction("BillConfirmation", "Cart");
        }

        public ActionResult BillConfirmation()
        {
            return View();
        }
    }
}