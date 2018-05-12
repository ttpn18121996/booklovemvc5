using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLBanSach.Models
{
    public class CartViewModel
    {
        dbQLBansachDataContext data = new dbQLBansachDataContext();

        public int iMasach { set; get; }

        public string sTensach { set; get; }

        public string sAnhbia { set; get; }

        public Double dDongia { set; get; }

        public int iSoluong { set; get; }

        public Double dThanhtien
        {
            get { return iSoluong * dDongia; }
        }

        public CartViewModel(int Masach)
        {
            iMasach = Masach;
            SACH sach = data.SACHes.Single(n => n.Masach == iMasach);
            sTensach = sach.Tensach;
            sAnhbia = sach.Anhbia;
            dDongia = double.Parse(sach.Giaht.ToString());
            iSoluong = 1;
        }
    }
}