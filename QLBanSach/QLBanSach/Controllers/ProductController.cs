using QLBanSach.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using PagedList;
using PagedList.Mvc;

namespace QLBanSach.Controllers
{
    public class ProductController : Controller
    {
        //Tạo đối tượng chứa toàn bộ CSDL từ dbQLBansach
        dbQLBansachDataContext data = new dbQLBansachDataContext();

        //Lấy danh sách sản phẩm theo số lượng
        private List<SACH> LaySachMoi(int count, int id = 0, string cat = "")
        {
            //Sắp xếp giảm dần theo ngày cập nhật
            if (cat == "chu-de" && id != 0)
            {
                return data.SACHes.Where(a => a.MaCD == id).OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
            }
            else if (cat == "nxb" && id != 0)
            {
                return data.SACHes.Where(a => a.MaCD == id).OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
            }
            else
                return data.SACHes.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }
        
        public ActionResult Details(int id)
        {
            var sach = from s in data.SACHes
                       join cd in data.CHUDEs on s.MaCD equals cd.MaCD
                       join nxb in data.NHAXUATBANs on s.MaNXB equals nxb.MaNXB
                       where (s.Masach == id)
                       //select s;
                       select new ProductViewModel
                       {
                           Masach = s.Masach,
                           Tensach = s.Tensach,
                           Giaban = s.Giaban,
                           Giamgia = s.Giamgia,
                           Giaht = s.Giaht,
                           Anhbia = s.Anhbia,
                           TenCD = cd.TenChuDe,
                           TenNXB = nxb.TenNXB,
                           Mota = s.Mota
                       };
            return View(sach.SingleOrDefault());
        }
        public ActionResult Product(int ? page, int id = 0, string cat = "")
        {
            //Tạo biến quy định số sản phẩm trên 1 trang
            int pageSize = 6;
            //Tạo biến số trang
            int pageNum = (page ?? 1);

            var sach = LaySachMoi(15, id, cat);
            return View(sach.ToPagedList(pageNum, pageSize));
        }
	}
}