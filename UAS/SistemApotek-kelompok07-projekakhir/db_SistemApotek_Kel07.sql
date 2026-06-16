create database sistem_apotek;
use sistem_apotek;

-- 1
create table kategori (
    id_kategori int primary key auto_increment,
    nama_kategori varchar(50)
);

-- 2
create table karyawan (
    id_karyawan int primary key auto_increment,
    nama_karyawan varchar(100),
    jenis_kelamin enum('l', 'p'),
    alamat varchar(200),
    shift varchar(20)
);

-- 3
create table supplier (
    id_supplier int primary key auto_increment,
    nama_supplier varchar(100),
    alamat varchar(200),
    no_telpon varchar(12)
);

-- 4.
create table pelanggan (
    id_pelanggan int primary key auto_increment,
    nama_pelanggan varchar(100),
    jenis_kelamin enum('l', 'p'),
    alamat varchar(200),
    no_hp varchar(12)
);

-- 5.
create table obat (
    id_obat int primary key auto_increment,
    nama_obat varchar(100),
    harga int,
    stok int,
    id_kategori int,
    id_supplier int,
    foreign key (id_kategori) references kategori (id_kategori),
    foreign key (id_supplier) references supplier (id_supplier)
);

-- 6.
create table penjualan (
    id_penjualan int primary key auto_increment,
    tgl_penjualan date,
    id_karyawan int,
    id_pelanggan int,
    foreign key (id_karyawan) references karyawan (id_karyawan),
    foreign key (id_pelanggan) references pelanggan (id_pelanggan) 
);

-- 7.
create table detail_penjualan (
    id_detail int primary key auto_increment,
    id_penjualan int,
    id_obat int,
    jumlah int,
    foreign key (id_penjualan) references penjualan (id_penjualan),
    foreign key (id_obat) references obat (id_obat)
);


insert into kategori (nama_kategori) values
('obat bebas'),
('obat bebas terbatas'),
('obat keras'),
('vitamin'),
('alat kesehatan'),
('perawatan bayi'),
('perawatan kulit'),
('obat herbal'),
('obat tetes'),
('sirup anak');

insert into karyawan (nama_karyawan, jenis_kelamin, alamat, shift) values
('ujang', 'l', 'bangkalan', 'pagi'),
('surya', 'l', 'kamal', 'siang'),
('pertiwi', 'p', 'surabaya', 'malam'),
('ahmad', 'l', 'telang', 'pagi'),
('fauzi', 'l', 'bangkalan', 'siang'),
('nur', 'p', 'kamal', 'malam'),
('hazizah', 'p', 'telang', 'pagi'),
('joko', 'l', 'surabaya', 'siang'),
('dina', 'p', 'bangkalan', 'malam'),
('ayu', 'p', 'kamal', 'pagi');

insert into supplier (nama_supplier, alamat, no_telpon) values
('pt kimia farma', 'bangkalan', '08111111111'),
('pt kalbe farma', 'surabaya', '08222222222'),
('pt sanbe farma', 'sidoarjo', '08333333333'),
('pt dexa medica', 'surabaya', '08444444444'),
('pt pharos', 'bangkalan', '08555555555'),
('pt tempo scan', 'surabaya', '08666666666'),
('pt soho global', 'malang', '08777777777'),
('pt konimex', 'surabaya', '08888888888'),
('pt meprofarm', 'sidoarjo', '08999999999'),
('pt bio farma', 'surabaya', '08101010101');

insert into pelanggan (nama_pelanggan, jenis_kelamin, alamat, no_hp) values
('iqbal', 'l', 'telang', '08123456789'),
('lyviana', 'p', 'kamal', '08123456780'),
('aisom', 'l', 'bangkalan', '08123456781'),
('zamzami', 'l', 'surabaya', '08123456782'),
('dandy', 'l', 'telang', '08123456783'),
('reza', 'l', 'kamal', '08123456784'),
('nanda', 'p', 'bangkalan', '08123456785'),
('rizky', 'l', 'surabaya', '08123456786'),
('maya', 'p', 'telang', '08123456787'),
('bayu', 'l', 'kamal', '08123456788');

insert into obat (nama_obat, harga, stok, id_kategori, id_supplier) values
('paracetamol 500mg', 5000, 50, 1, 1),
('promag', 8000, 30, 1, 2),
('amoxicillin 500mg', 15000, 40, 3, 3),
('vitamin c ipi', 6000, 100, 4, 4),
('tolak angin cair', 3500, 120, 8, 5),
('insto reguler', 14000, 25, 9, 6),
('sanmol sirup', 20000, 15, 10, 7),
('termometer digital', 35000, 10, 5, 8),
('minyak telon konitu', 18000, 45, 6, 8),
('bedak salicyl', 12000, 20, 7, 9);

insert into penjualan (tgl_penjualan, id_karyawan, id_pelanggan) values
('2026-06-01', 1, 1),
('2026-06-01', 2, 2),
('2026-06-02', 3, 3),
('2026-06-02', 4, 4),
('2026-06-03', 1, 5),
('2026-06-03', 2, 6),
('2026-06-04', 3, 7),
('2026-06-04', 4, 8),
('2026-06-05', 1, 9),
('2026-06-05', 2, 10);

insert into detail_penjualan (id_penjualan, id_obat, jumlah) values
(1, 1, 2),
(1, 4, 1),
(2, 2, 1),
(3, 3, 1),
(3, 5, 5),
(4, 6, 2),
(5, 7, 1),
(6, 8, 1),
(6, 9, 2),
(7, 10, 1),
(8, 1, 3),
(9, 2, 2),
(10, 4, 1),
(10, 5, 2);

-- mdl 3
select nama_obat, harga, stok
from obat
where harga < 10000;

select nama_obat, stok,
case
    when stok > 30 then 'stok aman'
    when stok >= 15 then 'stok menipis'
    else 'stok sedikit segera restock!'
end as status_stok
from obat;

-- mdl 4
select obat.nama_obat, obat.harga, kategori.nama_kategori 
from obat 
join kategori on obat.id_kategori = kategori.id_kategori;

select penjualan.id_penjualan, penjualan.tgl_penjualan, karyawan.nama_karyawan, pelanggan.nama_pelanggan
from penjualan 
join karyawan on penjualan.id_karyawan = karyawan.id_karyawan
join pelanggan on penjualan.id_pelanggan = pelanggan.id_pelanggan;

-- mdl 5
select kategori.nama_kategori, count(obat.id_obat) as jumlah_macam_obat
from kategori
join obat on kategori.id_kategori = obat.id_kategori
group by kategori.nama_kategori;

select obat.nama_obat, sum(detail_penjualan.jumlah) as total_terjual
from detail_penjualan
join obat on detail_penjualan.id_obat = obat.id_obat
group by obat.nama_obat
having total_terjual > 1;

-- mdl 6
select nama_obat, harga
from obat
where harga > (select avg(harga) from obat);

create view laporan_penjualan as
select p.id_penjualan, p.tgl_penjualan, o.nama_obat, dp.jumlah, o.harga, (dp.jumlah * o.harga) as total_harga
from penjualan p
join detail_penjualan dp on p.id_penjualan = dp.id_penjualan
join obat o on dp.id_obat = o.id_obat;


select nama_pelanggan, no_hp 
from pelanggan 
where jenis_kelamin = 'p' and alamat = 'kamal';


select nama_karyawan, alamat 
from karyawan 
where jenis_kelamin = 'l' and shift = 'siang';