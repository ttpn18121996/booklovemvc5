using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLBanSach.Models
{
    public class ProductViewModel
    {
        private int? _masach;

        public int? Masach
        {
            get { return _masach; }
            set { _masach = value; }
        }
        private string _tensach;

        public string Tensach
        {
            get { return _tensach; }
            set { _tensach = value; }
        }
        private string _tenCD;

        public string TenCD
        {
            get { return _tenCD; }
            set { _tenCD = value; }
        }
        private string _tenNXB;

        public string TenNXB
        {
            get { return _tenNXB; }
            set { _tenNXB = value; }
        }
        private Decimal? _giaban;

        public Decimal? Giaban
        {
            get { return _giaban; }
            set { _giaban = value; }
        }
        private int? _giamgia;

        public int? Giamgia
        {
            get { return _giamgia; }
            set { _giamgia = value; }
        }
        private Decimal? _giaht;

        public Decimal? Giaht
        {
            get { return _giaht; }
            set { _giaht = value; }
        }
        private string _anhbia;

        public string Anhbia
        {
            get { return _anhbia; }
            set { _anhbia = value; }
        }
        private string _mota;

        public string Mota
        {
            get { return _mota; }
            set { _mota = value; }
        }
    }
}