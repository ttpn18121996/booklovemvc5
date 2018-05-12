---Xoa CSDL QLBansach neu da co
use master
go
Drop Database QLBansach
-----Tao CSDL QLBansach
create database QLBANSACH
GO
use QLBANSACH
GO
set dateformat dmy;
GO
CREATE TABLE KHACHHANG
(
MaKH INT IDENTITY(1,1),
HoTen nVarchar(50) NOT NULL,
Taikhoan Varchar(50) UNIQUE,
Matkhau Varchar(50) NOT NULL,
Email Varchar(100) UNIQUE,
DiachiKH nVarchar(200),
DienthoaiKH Varchar(50),
Ngaysinh DATETIME
CONSTRAINT PK_Khachhang PRIMARY KEY(MaKH)
)
GO
Create Table CHUDE
(
MaCD int Identity(1,1),
TenChuDe nvarchar(50) NOT NULL,
CONSTRAINT PK_ChuDe PRIMARY KEY(MaCD)
)
GO
Create Table NHAXUATBAN
(
MaNXB int identity(1,1),
TenNXB nvarchar(50) NOT NULL,
Diachi NVARCHAR(200),
DienThoai VARCHAR(50),
CONSTRAINT PK_NhaXuatBan PRIMARY KEY(MaNXB)
)
Go
CREATE TABLE SACH
(
Masach INT IDENTITY(1,1),
Tensach NVARCHAR(100) NOT NULL,
Giaban Decimal(18,0) CHECK (Giaban>=0),
Giamgia int,
Giaht Decimal(18,0) CHECK (Giaht>=0),
Mota NVarchar(Max),
Anhbia VARCHAR(50),
Ngaycapnhat DATETIME,
Soluongton INT,
MaCD INT,
MaNXB INT,
Constraint PK_Sach Primary Key(Masach),
Constraint FK_Chude Foreign Key(MaCD) References CHUDE(MaCD),
Constraint FK_NhaXB Foreign Key(MaNXB)References

NHAXUATBAN(MANXB)

)
GO
CREATE TABLE TACGIA
(
MaTG INT IDENTITY(1,1),
TenTG NVARCHAR(50) NOT NULL,
Diachi NVARCHAR(100),
Tieusu nVarchar(Max),
Dienthoai VARCHAR(50),
CONSTRAINT PK_TacGia PRIMARY KEY(MaTG)
)
GO
CREATE TABLE VIETSACH(
MaTG INT,
Masach INT,
Vaitro NVARCHAR(50),
Vitri nVarchar(50),
CONSTRAINT PK_VietSach PRIMARY KEY(MaTG,Masach), CONSTRAINT
FK_Tacgia FOREIGN KEY (MaTG) REFERENCES TacGia(MaTG), CONSTRAINT
FK_Sach FOREIGN KEY (Masach) REFERENCES Sach(Masach)
)
GO
CREATE TABLE DONDATHANG
(
MaDonHang INT IDENTITY(1,1),
Dathanhtoan bit,
Tinhtranggiaohang bit,
Ngaydat Datetime,
Ngaygiao Datetime,
MaKH INT,
CONSTRAINT FK_Khachhang FOREIGN KEY ( MaKH )

REFERENCES Khachhang(MaKH),
CONSTRAINT PK_DonDatHang PRIMARY KEY(MaDonHang)

)
Go
CREATE TABLE CHITIETDONTHANG
(
MaDonHang INT,
Masach INT,
Soluong Int Check(Soluong>0),
Dongia Decimal(18,0) Check(Dongia>=0),
CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,Masach),
CONSTRAINT FK_Donhang FOREIGN KEY (Madonhang)

REFERENCES Dondathang(Madonhang),

CONSTRAINT FK_Sach1 FOREIGN KEY (Masach)

REFERENCES Sach(Masach)

)
go
--Thêm dữ liệu vào table CHUDE
insert into CHUDE values(N'Văn học')
insert into CHUDE values(N'Công nghệ thông tin')
insert into CHUDE values(N'Kinh tế')
insert into CHUDE values(N'Sách thiếu nhi')
go
--Thêm dữ liệu vào table NHAXUATBAN
insert into NHAXUATBAN values(N'Trẻ',N'192 Hàm Tử','0123456789')
insert into NHAXUATBAN values(N'Kim Đồng',N'192 Hàm Tử','0123456789')
insert into NHAXUATBAN values(N'Văn học',N'192 Hàm Tử','0123456789')
insert into NHAXUATBAN values(N'Văn Hoá Thông Tin',N'192 Hàm Tử','0123456789')
go
--Thêm dữ liệu vào table SACH
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Khéo ăn nói sẽ có được thiên hạ',79000,0,79000,N'Xã hội hiện đại, từ xin việc đến thăng chức, từ tình yêu đến hôn nhân, từ giao lưu đến hợp tác… không việc gì không cần tài ăn nói.','kheo-an-noi-se-co-duoc-thien-ha.jpg','01/01/2018', 50,3,3)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Đời ngắn đừng ngủ dài',48000,0,48000,N'Bằng những lời chia sẻ thật ngắn gọn, dễ hiểu về những trải nghiệm và suy ngẫm trong đời, Robin Sharma tiếp tục phong cách viết của ông từ cuốn sách Điều vĩ đại đời thường để mang đến cho độc giả những bài viết như lời tâm sự, vừa chân thành vừa sâu sắc.','doi-ngan-dung-ngu-dai.jpg','01/01/2018', 50,3,3)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tự học lắp ráp và sửa chữa máy tính',34000,0,34000,N'Mời các bạn đón đọc Tự Học Lắp Ráp Và Sửa Chữa Máy Tính.','tu_hoc_lap_rap_va_sua_chua_mt.jpg','01/01/2018', 50,2,4)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tự học nhanh đồ họa văn phòng',32000,0,32000,N'Với quyển Tự Học Nhanh Đồ Họa Văn Phòng, người học sẽ được trang bị kiến thức đồ họa văn phòng, những cách chỉnh sửa, vẽ hình ảnh, sơ đồ tổ chức đơn giản sử dụng cho mục đích văn phòng.','tu_hoc_nhanh_do_hoa_van_phong.jpg','01/01/2018', 50,2,4)

insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tôi thấy hoa vàng trên cỏ xanh',68000,0,68000,N'sách để đọc','toi_thay_hoa_vang-large.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Mắt biếc',65000,0,65000,N'sách để đọc','mat-biec.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Cô gái đến từ hôm qua',60000,50,30000,N'sách để đọc','co-gai-den-tu-hom-qua.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Thiên thần nhỏ của tôi',58000,0,58000,N'sách để đọc','thien-than-nho-cua-toi.jpg','01/01/2018', 50,1,1)

insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Bảy bước tới mùa hè',99000,20,79000,N'Bảy bước tới mùa hè là tác phẩm mới nhất của Nguyễn Nhật Ánh, được nhà văn đề tặng "Những năm ấu thơ", như một món quà dành tặng các bạn đọc thân thiết của mình nhân dịp đầu năm mới.','bay-buoc-toi-mua-he_2.jpg','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Đi qua hoa cúc',56000,20,45000,N'Cuốn Đi Qua Hoa Cúc là tập truyện dài của Nguyễn Nhật Ánh, mở đầu câu truyện tác giả kể lại tuổi ấu thơ hồn nhiên của nhân vật trong truyện, kết hợp với tả cảnh ở miền quê, những ngôi nhà nằm dọc hai bên đường đá sỏi dọc theo hai bên hàng dâm bụt và cả cây sứ cây bàng tỏa bóng mát, tỏa hương thơm trước sân nhà. Một nét vẽ nên thơ thật đầm ấm ở một vùng quê xa xôi tác giả dường như làm ấm lòng cho người đọc. Thật vậy mỗi cốt truyện của Nguyễn Nhật Ánh đã phác họa lên một nét quê hương ngọt ngào, một thời ấu thơ đẹp, một tình yêu của tuổi học trò cũng hòa lẫn tình yêu khát khao của bao lứa tuổi. Cuốn truyện dài Đi Qua Hoa Cúc là một trong những tác phẩm tuyệt tác hay của tác giả làm thôi thúc người đọc thêm nhiều ấn tượng và sự lôi cuốn tràn dâng trong lòng bạn đọc','di-qua-hoa-cuc.gif','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Có hai con mèo ngồi bên cửa sổ',70000,20,56000,N'Cuốn truyện có độ dầy vừa phải, 67 hình vẽ của họa sĩ Đỗ Hoàng Tường sinh động đến từng nét nũng nịu hay kiêu căng của nàng mèo người yêu mèo Gấu, câu chuyện thì hấp dẫn duyên dáng điểm những bài thơ tình lãng mạn nao lòng song đọc to lên thì khiến cười hinh hích…','hai_con_meo_1_2.jpg','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Thám tử lừng danh conan - Tuyển tập đặc biệt: Những câu chuyện lãng mạn - Tập 1',45000,0,45000,N'Cuốn sách này tập hợp những mẩu chuyện lãng mạn giữa Conan (Shinichi) và Ran. Chuyện tình giữa Conan (Shinichi) và Ran khiến độc giả không sao rời mắt được... Tình cảm giữa họ tiến triển từng bước, như mưa dầm thấm lâu...!?','conan.jpg','01/01/2018', 50,4,2)

insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Khéo ăn nói sẽ có được thiên hạ 1',79000,0,79000,N'Xã hội hiện đại, từ xin việc đến thăng chức, từ tình yêu đến hôn nhân, từ giao lưu đến hợp tác… không việc gì không cần tài ăn nói.','kheo-an-noi-se-co-duoc-thien-ha.jpg','01/01/2018', 50,3,3)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Đời ngắn đừng ngủ dài 1',48000,0,48000,N'Bằng những lời chia sẻ thật ngắn gọn, dễ hiểu về những trải nghiệm và suy ngẫm trong đời, Robin Sharma tiếp tục phong cách viết của ông từ cuốn sách Điều vĩ đại đời thường để mang đến cho độc giả những bài viết như lời tâm sự, vừa chân thành vừa sâu sắc.','doi-ngan-dung-ngu-dai.jpg','01/01/2018', 50,3,3)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tự học lắp ráp và sửa chữa máy tính 1',34000,0,34000,N'Mời các bạn đón đọc Tự Học Lắp Ráp Và Sửa Chữa Máy Tính.','tu_hoc_lap_rap_va_sua_chua_mt.jpg','01/01/2018', 50,2,4)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tự học nhanh đồ họa văn phòng 1',32000,0,32000,N'Với quyển Tự Học Nhanh Đồ Họa Văn Phòng, người học sẽ được trang bị kiến thức đồ họa văn phòng, những cách chỉnh sửa, vẽ hình ảnh, sơ đồ tổ chức đơn giản sử dụng cho mục đích văn phòng.','tu_hoc_nhanh_do_hoa_van_phong.jpg','01/01/2018', 50,2,4)

insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Tôi thấy hoa vàng trên cỏ xanh 1',68000,0,68000,N'sách để đọc','toi_thay_hoa_vang-large.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Mắt biếc 1',65000,0,65000,N'sách để đọc','mat-biec.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Cô gái đến từ hôm qua 1',60000,50,30000,N'sách để đọc','co-gai-den-tu-hom-qua.jpg','01/01/2018', 50,1,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Thiên thần nhỏ của tôi 1',58000,0,58000,N'sách để đọc','thien-than-nho-cua-toi.jpg','01/01/2018', 50,1,1)

insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Bảy bước tới mùa hè 1',99000,20,79000,N'Bảy bước tới mùa hè là tác phẩm mới nhất của Nguyễn Nhật Ánh, được nhà văn đề tặng "Những năm ấu thơ", như một món quà dành tặng các bạn đọc thân thiết của mình nhân dịp đầu năm mới.','bay-buoc-toi-mua-he_2.jpg','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Đi qua hoa cúc 1',56000,20,45000,N'Cuốn Đi Qua Hoa Cúc là tập truyện dài của Nguyễn Nhật Ánh, mở đầu câu truyện tác giả kể lại tuổi ấu thơ hồn nhiên của nhân vật trong truyện, kết hợp với tả cảnh ở miền quê, những ngôi nhà nằm dọc hai bên đường đá sỏi dọc theo hai bên hàng dâm bụt và cả cây sứ cây bàng tỏa bóng mát, tỏa hương thơm trước sân nhà. Một nét vẽ nên thơ thật đầm ấm ở một vùng quê xa xôi tác giả dường như làm ấm lòng cho người đọc. Thật vậy mỗi cốt truyện của Nguyễn Nhật Ánh đã phác họa lên một nét quê hương ngọt ngào, một thời ấu thơ đẹp, một tình yêu của tuổi học trò cũng hòa lẫn tình yêu khát khao của bao lứa tuổi. Cuốn truyện dài Đi Qua Hoa Cúc là một trong những tác phẩm tuyệt tác hay của tác giả làm thôi thúc người đọc thêm nhiều ấn tượng và sự lôi cuốn tràn dâng trong lòng bạn đọc','di-qua-hoa-cuc.gif','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Có hai con mèo ngồi bên cửa sổ 1',70000,20,56000,N'Cuốn truyện có độ dầy vừa phải, 67 hình vẽ của họa sĩ Đỗ Hoàng Tường sinh động đến từng nét nũng nịu hay kiêu căng của nàng mèo người yêu mèo Gấu, câu chuyện thì hấp dẫn duyên dáng điểm những bài thơ tình lãng mạn nao lòng song đọc to lên thì khiến cười hinh hích…','hai_con_meo_1_2.jpg','01/01/2018', 50,4,1)
insert into SACH(Tensach,Giaban,Giamgia,Giaht,Mota,Anhbia,Ngaycapnhat,Soluongton,MaCD,MaNXB) values(N'Thám tử lừng danh conan - Tuyển tập đặc biệt: Những câu chuyện lãng mạn - Tập 2',45000,0,45000,N'Cuốn sách này tập hợp những mẩu chuyện lãng mạn giữa Conan (Shinichi) và Ran. Chuyện tình giữa Conan (Shinichi) và Ran khiến độc giả không sao rời mắt được... Tình cảm giữa họ tiến triển từng bước, như mưa dầm thấm lâu...!?','conan.jpg','01/01/2018', 50,4,2)

go
--Thêm dữ liệu vào table KHACHHANG
insert into KHACHHANG(HoTen,Taikhoan,Matkhau,Email,DiachiKH,DienthoaiKH,Ngaysinh) values(N'Trịnh Trần Phương Nam','nam','123','ttpn18121996@gmail.com',N'Quận 3','01264196421','18/12/1996')
insert into KHACHHANG(HoTen,Taikhoan,Matkhau,Email,DiachiKH,DienthoaiKH,Ngaysinh) values(N'Nguyễn Thị Ngọc Nhi','nhi','123','ngocnhi.nt95@gmail.com',N'Quận 8','0997427948','09/04/1995')
insert into KHACHHANG(HoTen,Taikhoan,Matkhau,Email,DiachiKH,DienthoaiKH,Ngaysinh) values(N'Đoàn Thị Huỳnh Như','nhu','123','doanthihuynhnhu1996@gmail.com',N'Quận 12','01638481740','22/11/1996')
insert into KHACHHANG(HoTen,Taikhoan,Matkhau,Email,DiachiKH,DienthoaiKH,Ngaysinh) values(N'Nguyễn Thành Trung','trung','123','keanmayvodoi@gmail.com',N'Quận 12','01627787214','15/09/1996')
insert into KHACHHANG(HoTen,Taikhoan,Matkhau,Email,DiachiKH,DienthoaiKH,Ngaysinh) values(N'Nguyễn Minh Khánh','khanh','123','luxu01886885039@gmail.com',N'Quận 12','01867890913','24/11/1995')