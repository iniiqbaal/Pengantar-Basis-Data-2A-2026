-- create database db_modul5
use db_modul5

-- -- 1. Hapus tabel jika sudah ada (wajib urut dari anak ke induk)
-- drop table if exists nilai;
-- drop table if exists krs;
-- drop table if exists mata_kuliah;
-- drop table if exists mahasiswa;
-- drop table if exists dosen;

-- -- 2. Pembuatan Tabel (DDL)
-- create table dosen (
--     id_dosen int primary key,
--     nama_dosen varchar(100)
-- );

-- create table mahasiswa (
--     nim varchar(20) primary key,
--     nama varchar(100),
--     angkatan int,
--     jurusan varchar(100)
-- );

-- create table mata_kuliah (
--     kode_mk varchar(20) primary key,
--     nama_mk varchar(100),
--     sks int,
--     id_dosen int,
--     foreign key (id_dosen) references dosen(id_dosen)
-- );

-- create table krs (
--     id_krs int primary key,
--     nim varchar(20),
--     kode_mk varchar(20),
--     semester int,
--     foreign key (nim) references mahasiswa(nim),
--     foreign key (kode_mk) references mata_kuliah(kode_mk)
-- );

-- create table nilai (
--     id_nilai int primary key,
--     nim varchar(20),
--     kode_mk varchar(20),
--     nilai_angka decimal(5,2),
--     nilai_huruf varchar(5),
--     foreign key (nim) references mahasiswa(nim),
--     foreign key (kode_mk) references mata_kuliah(kode_mk)
-- );

-- -- 3. Pengisian Data (DML)
-- insert into dosen values
-- (1, 'Dr. Ahmad'), (2, 'Prof. Budi'), (3, 'Siti Rahma, M.Kom'), 
-- (4, 'Rudi Hartono, M.T'), (5, 'Lina Kusuma, M.Kom');

-- insert into mahasiswa values
-- ('21001', 'Andi Saputra', 2021, 'Teknik Informatika'),
-- ('22001', 'Budi Santoso', 2022, 'Sistem Informasi'),
-- ('22002', 'Citra Dewi', 2022, 'Teknik Informatika'),
-- ('23001', 'Dewi Lestari', 2023, 'Sistem Informasi'),
-- ('23002', 'Eko Prasetyo', 2023, 'Teknik Informatika'),
-- ('24001', 'Fajar Hidayat', 2024, 'Sistem Informasi'),
-- ('24002', 'Gina Putri', 2024, 'Teknik Informatika'),
-- ('24003', 'Hendra Wijaya', 2024, 'Sistem Informasi'),
-- ('25001', 'Indra Mahendra', 2025, 'Teknik Informatika'),
-- ('25002', 'Joko Purwanto', 2025, 'Sistem Informasi'),
-- ('25003', 'Kiara Sabrina', 2025, 'Teknik Informatika'),
-- ('25004', 'Laura Mala', 2025, 'Sistem Informasi');

-- insert into mata_kuliah values
-- ('MK01', 'Pengantar Basis Data', 3, 1),
-- ('MK02', 'Pemrograman Berbasis Web', 3, 2),
-- ('MK03', 'Desain Manajemen Jaringan', 2, 3),
-- ('MK04', 'Sistem Operasi', 3, 1),
-- ('MK05', 'Algoritma dan Dasar Pemrograman', 2, 2),
-- ('MK06', 'Kecerdasan Buatan', 3, 4),
-- ('MK07', 'Data Mining', 2, 5);

-- insert into krs values
-- (1, '21001', 'MK01', 1), (2, '22001', 'MK01', 1),
-- (3, '22001', 'MK02', 2), (4, '22002', 'MK02', 2),
-- (5, '23001', 'MK03', 1), (6, '23002', 'MK04', 3),
-- (7, '24001', 'MK02', 1), (8, '24002', 'MK03', 2),
-- (9, '24003', 'MK01', 3), (10, '25001', 'MK05', 2),
-- (11, '25002', 'MK06', 3), (12, '25003', 'MK07', 1),
-- (13, '25004', 'MK01', 2);

-- insert into nilai values
-- (1, '21001', 'MK01', 82, 'A'), (2, '22001', 'MK01', 85, 'A'),
-- (3, '22001', 'MK02', 78, 'B'), (4, '22002', 'MK02', 80, 'A'),
-- (5, '23001', 'MK03', 75, 'B'), (6, '23002', 'MK04', 88, 'A'),
-- (7, '24001', 'MK02', 90, 'A'), (8, '24002', 'MK03', 77, 'B'),
-- (9, '24003', 'MK01', 84, 'A'), (10, '25001', 'MK05', 79, 'B'),
-- (11, '25002', 'MK06', 83, 'A'), (12, '25003', 'MK07', 76, 'B'),
-- (13, '25004', 'MK01', 81, 'A');









-- -- soal 1: angkatan dominan
-- select angkatan, count(nim) as Total_Mahasiswa
-- from mahasiswa
-- group by angkatan
-- having count(nim) > 1
-- order by Total_Mahasiswa desc;

-- -- soal 2: statistik sks kurikulum
-- select 
--     min(sks) as SKS_Minimal, 
--     max(sks) as SKS_Maksimal, 
--     avg(sks) as Rata_Rata_SKS, 
--     count(kode_mk) as Total_Mata_Kuliah
-- from mata_kuliah;

-- -- soal 3: total beban mahasiswa semester ganjil
-- select m.nim, m.nama, sum(mk.sks) as Total_SKS
-- from krs k
-- join mahasiswa m on k.nim = m.nim
-- join mata_kuliah mk on k.kode_mk = mk.kode_mk
-- where k.semester in (1, 3)
-- group by m.nim, m.nama;

-- -- soal 4: identifikasi mahasiswa beban tinggi
-- select k.nim, sum(mk.sks) as Total_SKS
-- from krs k
-- join mata_kuliah mk on k.kode_mk = mk.kode_mk
-- group by k.nim
-- having sum(mk.sks) > 5;

-- -- soal 5: sebaran sks mata kuliah
-- select sks, 
--        count(kode_mk) as Total_MK,
--        sum(sks) as Total_Akumulasi_SKS
-- from mata_kuliah
-- group by sks
-- having count(kode_mk) > 1;
