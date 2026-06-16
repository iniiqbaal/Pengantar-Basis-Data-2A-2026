create database tugasmodul6pbd;
use tugasmodul6pbd;

create table mahasiswa (
    nim varchar(20) primary key,
    nama varchar(100),
    angkatan int,
    jurusan varchar(100)
);

create table dosen (
    id_dosen int primary key,
    nama_dosen varchar(100)
);

create table mata_kuliah (
    kode_mk varchar(20) primary key,
    nama_mk varchar(100),
    sks int,
    id_dosen int,
    foreign key (id_dosen) references dosen(id_dosen)
);

create table krs (
    id_krs int primary key,
    nim varchar(20),
    kode_mk varchar(20),
    semester int,
    foreign key (nim) references mahasiswa(nim),
    foreign key (kode_mk) references mata_kuliah(kode_mk)
);

create table nilai (
    id_nilai int primary key,
    nim varchar(20),
    kode_mk varchar(20),
    nilai_angka decimal(5,2),
    nilai_huruf varchar(2),
    foreign key (nim) references mahasiswa(nim),
    foreign key (kode_mk) references mata_kuliah(kode_mk)
);


insert into mahasiswa (nim, nama, angkatan, jurusan) values
('21001', 'Andi Saputra', 2021, 'Teknik Informatika'),
('22001', 'Budi Santoso', 2022, 'Sistem Informasi'),
('22002', 'Citra Dewi', 2022, 'Teknik Informatika'),
('23001', 'Dewi Lestari', 2023, 'Sistem Informasi'),
('23002', 'Eko Prasetyo', 2023, 'Teknik Informatika'),
('24001', 'Fajar Hidayat', 2024, 'Sistem Informasi'),
('24002', 'Gina Putri', 2024, 'Teknik Informatika'),
('24003', 'Hendra Wijaya', 2024, 'Sistem Informasi'),
('25001', 'Indra Mahendra', 2025, 'Teknik Informatika'),
('25002', 'Joko Purwanto', 2025, 'Sistem Informasi'),
('25003', 'Kiara Sabrina', 2025, 'Teknik Informatika'),
('25004', 'Laura Mala', 2025, 'Sistem Informasi');

insert into dosen (id_dosen, nama_dosen) values
(1, 'Dr. Ahmad'),
(2, 'Prof. Budi'),
(3, 'Siti Rahma, M.Kom'),
(4, 'Rudi Hartono, M.T'),
(5, 'Lina Kusuma, M.Kom');

insert into mata_kuliah (kode_mk, nama_mk, sks, id_dosen) values
('MK01', 'Pengantar Basis Data', 3, 1),
('MK02', 'Pemrograman Berbasis Web', 3, 2),
('MK03', 'Desain Manajemen Jaringan', 2, 3),
('MK04', 'Sistem Operasi', 3, 1),
('MK05', 'Algoritma dan Dasar Pemrograman', 2, 2),
('MK06', 'Kecerdasan Buatan', 3, 4),
('MK07', 'Data Mining', 2, 5);

insert into krs (id_krs, nim, kode_mk, semester) values
(1, '21001', 'MK01', 1),
(2, '22001', 'MK01', 1),
(3, '22001', 'MK02', 2),
(4, '22002', 'MK02', 2),
(5, '23001', 'MK03', 1),
(6, '23002', 'MK04', 3),
(7, '24001', 'MK02', 1),
(8, '24002', 'MK03', 2),
(9, '24003', 'MK01', 3),
(10, '25001', 'MK05', 2),
(11, '25002', 'MK06', 3),
(12, '25003', 'MK07', 1),
(13, '25004', 'MK01', 2);

insert into nilai (id_nilai, nim, kode_mk, nilai_angka, nilai_huruf) values
(1, '21001', 'MK01', 82, 'A'),
(2, '22001', 'MK01', 85, 'A'),
(3, '22001', 'MK02', 78, 'B'),
(4, '22002', 'MK02', 80, 'A'),
(5, '23001', 'MK03', 75, 'B'),
(6, '23002', 'MK04', 88, 'A'),
(7, '24001', 'MK02', 90, 'A'),
(8, '24002', 'MK03', 77, 'B'),
(9, '24003', 'MK01', 84, 'A'),
(10, '25001', 'MK05', 79, 'B'),
(11, '25002', 'MK06', 83, 'A'),
(12, '25003', 'MK07', 76, 'B'),
(13, '25004', 'MK01', 81, 'A');

-- 1 nilai di atas rata-rata
select m.nim, m.nama, n.nilai_angka
from mahasiswa m
join nilai n on m.nim = n.nim
where n.nilai_angka > (select avg(nilai_angka) from nilai);

-- 2 daftar mata kuliah budi santoso
select kode_mk, nama_mk
from mata_kuliah
where kode_mk in (
    select kode_mk 
    from krs
    where nim = (select nim from mahasiswa where nama = 'Budi Santoso')
);

-- 3 mahasiswa yang punya nilai
select m.nim, m.nama
from mahasiswa m
where exists (
    select 1 
    from nilai n
    where n.nim = m.nim
);

-- 4 rata-rata nilai mk01 dan mk02
select avg(nilai_angka) as rata_rata_mk01_mk02
from (
    select nilai_angka
    from nilai
    where kode_mk in ('MK01', 'MK02')
) as nilai_sementara;

-- membuat view
create or replace view v_transkrip_lengkap as
select m.nim, m.nama as nama_mahasiswa, mk.nama_mk, n.nilai_huruf
from mahasiswa m
join nilai n on m.nim = n.nim
join mata_kuliah mk on n.kode_mk = mk.kode_mk;

-- memanggil view untuk nilai a
select *
from v_transkrip_lengkap
where nilai_huruf = 'A';