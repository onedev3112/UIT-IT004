/* ============================================================================
   IT004 - CSDL (UIT) | FILE SQL MẪU THỰC HÀNH ÔN CUỐI KỲ (TỰ SOẠN)
   Hệ quản trị: MS SQL Server (T-SQL)
   Đồng bộ với: output/CK_NGAN_HANG_BAI_TAP_LUYEN_PHAN_XA.md (Phần A & Phần B)
   Mục đích: Tạo lược đồ + dữ liệu mẫu cài sẵn edge cases (số lượng 0, đồng hạng
             cực trị, bẫy <> ở phủ định, bẫy phép chia, trạng thái DaHuy) để tự
             chạy thực hành và đối chiếu kết quả trên SSMS / Azure Data Studio.
   Lưu ý: Dữ liệu tự soạn, không phải đề thi gốc.
   ============================================================================ */

-- Tùy chọn: tạo CSDL riêng nếu chưa có
-- CREATE DATABASE IT004_ON_CK_THUCHANH;
-- GO
-- USE IT004_ON_CK_THUCHANH;
-- GO

/* ----------------------------------------------------------------------------
   PHẦN 1: DỌN BẢNG CŨ & TẠO LƯỢC ĐỒ
   ---------------------------------------------------------------------------- */
DROP TABLE IF EXISTS PHANCONG_GD;
DROP TABLE IF EXISTS DANGKY;
DROP TABLE IF EXISTS KHOAHOC;
DROP TABLE IF EXISTS GIANGVIEN;
DROP TABLE IF EXISTS HOCVIEN;
DROP TABLE IF EXISTS KHOA;
GO

CREATE TABLE KHOA (
    MaKhoa  CHAR(4)      PRIMARY KEY,
    TenKhoa NVARCHAR(60) NOT NULL,
    NhiemVu VARCHAR(30)  NOT NULL
        CHECK (NhiemVu IN ('DaoTaoChuyenSau', 'ThucHanhUngDung'))
);

CREATE TABLE GIANGVIEN (
    MaGV    CHAR(4)      PRIMARY KEY,
    HoTenGV NVARCHAR(60) NOT NULL,
    TrinhDo VARCHAR(15)  NOT NULL
        CHECK (TrinhDo IN ('CuNhan', 'ThacSi', 'TienSi')),
    MaKhoa  CHAR(4)      NOT NULL
        REFERENCES KHOA(MaKhoa)
);

CREATE TABLE KHOAHOC (
    MaKH        CHAR(3)      PRIMARY KEY,
    TenKH       NVARCHAR(80) NOT NULL,
    CapDo       VARCHAR(15)  NOT NULL
        CHECK (CapDo IN ('CoBan', 'TrungCap', 'NangCao')),
    HocPhi      INT          NOT NULL CHECK (HocPhi > 0),
    SiSoToiDa   INT          NOT NULL CHECK (SiSoToiDa > 0),
    SiSoHienTai INT          NOT NULL DEFAULT 0 CHECK (SiSoHienTai >= 0),
    TrangThai   VARCHAR(15)  NOT NULL DEFAULT 'MoDangKy'
        CHECK (TrangThai IN ('MoDangKy', 'DangHoc', 'DaKetThuc')),
    MaKhoa      CHAR(4)      NOT NULL
        REFERENCES KHOA(MaKhoa)
);

CREATE TABLE HOCVIEN (
    MaHV     CHAR(4)      PRIMARY KEY,
    HoTenHV  NVARCHAR(60) NOT NULL,
    NgaySinh DATE         NOT NULL,
    ThanhPho NVARCHAR(40) NOT NULL
);

CREATE TABLE DANGKY (
    MaHV         CHAR(4)       NOT NULL REFERENCES HOCVIEN(MaHV),
    MaKH         CHAR(3)       NOT NULL REFERENCES KHOAHOC(MaKH),
    NgayDK       DATE          NOT NULL,
    TinhTrangTT  VARCHAR(20)   NOT NULL
        CHECK (TinhTrangTT IN ('DaThanhToan', 'ChuaThanhToan', 'DaHuy')),
    DiemCuoiKhoa DECIMAL(4, 2) NULL,
    PRIMARY KEY (MaHV, MaKH)
);

CREATE TABLE PHANCONG_GD (
    MaPC     CHAR(4)     PRIMARY KEY,
    MaGV     CHAR(4)     NOT NULL REFERENCES GIANGVIEN(MaGV),
    MaKH     CHAR(3)     NOT NULL REFERENCES KHOAHOC(MaKH),
    VaiTro   VARCHAR(15) NOT NULL
        CHECK (VaiTro IN ('GiangChinh', 'TroGiang')),
    SoGioDay INT         NOT NULL CHECK (SoGioDay > 0)
);
GO

/* ----------------------------------------------------------------------------
   PHẦN 2: NẠP DỮ LIỆU MẪU (THỎA CẢ 4 RBTV & CÀI SẴN EDGE CASES)
   ---------------------------------------------------------------------------- */
INSERT INTO KHOA (MaKhoa, TenKhoa, NhiemVu) VALUES
('KH01', N'Hệ thống Thông tin', 'DaoTaoChuyenSau'),
('KH02', N'Khoa học Máy tính',  'DaoTaoChuyenSau'),
('KH03', N'Mạng máy tính',      'ThucHanhUngDung'); -- Edge case: 0 khóa NangCao (SQL-5)

INSERT INTO GIANGVIEN (MaGV, HoTenGV, TrinhDo, MaKhoa) VALUES
('GV01', N'Nguyễn Minh Khoa', 'TienSi', 'KH01'),
('GV02', N'Trần Thu Hà',      'ThacSi', 'KH01'),
('GV03', N'Lê Quốc Bảo',      'CuNhan', 'KH01'),
('GV04', N'Phạm Gia Huy',     'TienSi', 'KH02'), -- Edge case SQL-4: vừa GiangChinh NangCao vừa TroGiang CoBan
('GV05', N'Võ Lan Anh',       'ThacSi', 'KH02'), -- Edge case SQL-8a: 0 khóa được phân công
('GV06', N'Đặng Hữu Phước',   'ThacSi', 'KH03'); -- Edge case SQL-8a: 0 khóa được phân công

INSERT INTO KHOAHOC (MaKH, TenKH, CapDo, HocPhi, SiSoToiDa, SiSoHienTai, TrangThai, MaKhoa) VALUES
('C01', N'SQL Nền tảng',               'CoBan',   2500000, 3, 3, 'DaKetThuc', 'KH01'), -- Kín chỗ (3/3)
('C02', N'Tối ưu Truy vấn SQL',        'NangCao', 4500000, 2, 2, 'DangHoc',   'KH01'), -- Kín chỗ (2/2, có thêm 1 lượt DaHuy)
('C03', N'Thiết kế CSDL Doanh nghiệp', 'NangCao', 5000000, 4, 3, 'DangHoc',   'KH01'), -- Chưa kín (3/4)
('C04', N'Kho dữ liệu & OLAP',         'NangCao', 6000000, 4, 1, 'MoDangKy',  'KH02'),
('C05', N'Quản trị Mạng cơ bản',       'CoBan',   3000000, 5, 1, 'DangHoc',   'KH03');

INSERT INTO HOCVIEN (MaHV, HoTenHV, NgaySinh, ThanhPho) VALUES
('HV01', N'Nguyễn Hải Nam',  '2003-12-05', N'TP.HCM'),     -- Sinh T12, đạt phép chia SQL-6, đồng hạng MAX (3)
('HV02', N'Trần Ngọc Mai',   '2004-12-20', N'Đồng Nai'),   -- Sinh T12, bẫy phép chia (2 NangCao nhưng C04 thuộc KH02!), đồng hạng MAX (3)
('HV03', N'Lê Hoàng Phúc',   '2003-05-14', N'TP.HCM'),     -- Có lượt DaHuy & ChuaThanhToan
('HV04', N'Phạm Khánh Linh', '2002-08-19', N'Bình Dương'),
('HV05', N'Bùi Tuấn Kiệt',   '2004-03-11', N'Cần Thơ');    -- Chưa đăng ký khóa nào

INSERT INTO DANGKY (MaHV, MaKH, NgayDK, TinhTrangTT, DiemCuoiKhoa) VALUES
('HV01', 'C01', '2025-01-10', 'DaThanhToan',   9.00),
('HV01', 'C02', '2025-02-15', 'DaThanhToan',   8.50),
('HV01', 'C03', '2025-03-01', 'DaThanhToan',   9.50),
('HV02', 'C01', '2025-01-12', 'DaThanhToan',   8.00),
('HV02', 'C02', '2025-02-20', 'DaThanhToan',   7.50),
('HV02', 'C04', '2025-04-05', 'DaThanhToan',   NULL),
('HV03', 'C01', '2025-01-15', 'DaThanhToan',   7.00),
('HV03', 'C02', '2025-02-25', 'DaHuy',         NULL),
('HV03', 'C03', '2025-03-10', 'ChuaThanhToan', NULL),
('HV04', 'C03', '2025-03-12', 'DaThanhToan',   8.00),
('HV04', 'C05', '2025-03-18', 'DaThanhToan',   8.50);

INSERT INTO PHANCONG_GD (MaPC, MaGV, MaKH, VaiTro, SoGioDay) VALUES
('PC01', 'GV02', 'C01', 'GiangChinh', 20),
('PC02', 'GV03', 'C01', 'GiangChinh', 15),
('PC03', 'GV01', 'C02', 'GiangChinh', 24),
('PC04', 'GV02', 'C02', 'TroGiang',   12),
('PC05', 'GV01', 'C03', 'GiangChinh', 24),
('PC06', 'GV02', 'C03', 'TroGiang',   16),
('PC07', 'GV04', 'C04', 'GiangChinh', 30),
('PC08', 'GV03', 'C05', 'TroGiang',   10),
('PC09', 'GV04', 'C05', 'TroGiang',    8); -- Cài bẫy <> cho SQL-4 (GV04 vẫn phải bị loại!)
GO

/* ----------------------------------------------------------------------------
   PHẦN 3: CÁC CÂU TRUY VẤN MẪU (SQL-1 ĐẾN SQL-8b)
   ---------------------------------------------------------------------------- */

-- [SQL-1] Lọc, nối, BETWEEN, ORDER BY nhiều tiêu chí
-- Kết quả kỳ vọng: C03 (5000000), C02 (4500000), C01 (2500000)
SELECT KH.MaKH, KH.TenKH, KH.HocPhi, K.TenKhoa
FROM KHOAHOC KH
JOIN KHOA K ON KH.MaKhoa = K.MaKhoa
WHERE K.NhiemVu = 'DaoTaoChuyenSau'
  AND KH.HocPhi BETWEEN 2000000 AND 5000000
ORDER BY KH.HocPhi DESC, KH.MaKH ASC;

-- [SQL-2] Nối 3 bảng, lọc MONTH / YEAR
-- Kết quả kỳ vọng: (HV01, C02), (HV01, C03), (HV02, C02), (HV02, C04)
SELECT HV.MaHV, HV.HoTenHV, KH.TenKH
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
WHERE MONTH(HV.NgaySinh) = 12
  AND KH.CapDo = 'NangCao'
  AND YEAR(DK.NgayDK) = 2025
  AND DK.TinhTrangTT = 'DaThanhToan';

-- [SQL-3] "Cả hai" — Cách 1: INTERSECT
-- Kết quả kỳ vọng: HV01, HV02, HV04
(
    SELECT HV.MaHV, HV.HoTenHV
    FROM HOCVIEN HV
    JOIN DANGKY DK ON HV.MaHV = DK.MaHV
    JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
    WHERE DK.TinhTrangTT = 'DaThanhToan'
      AND YEAR(DK.NgayDK) = 2025
      AND KH.CapDo = 'CoBan'
)
INTERSECT
(
    SELECT HV.MaHV, HV.HoTenHV
    FROM HOCVIEN HV
    JOIN DANGKY DK ON HV.MaHV = DK.MaHV
    JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
    WHERE DK.TinhTrangTT = 'DaThanhToan'
      AND YEAR(DK.NgayDK) = 2025
      AND KH.CapDo = 'NangCao'
);

-- [SQL-3] "Cả hai" — Cách 2: EXISTS
SELECT HV.MaHV, HV.HoTenHV
FROM HOCVIEN HV
WHERE EXISTS (
    SELECT 1
    FROM DANGKY DK
    JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
    WHERE DK.MaHV = HV.MaHV
      AND DK.TinhTrangTT = 'DaThanhToan'
      AND YEAR(DK.NgayDK) = 2025
      AND KH.CapDo = 'CoBan'
)
AND EXISTS (
    SELECT 1
    FROM DANGKY DK
    JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
    WHERE DK.MaHV = HV.MaHV
      AND DK.TinhTrangTT = 'DaThanhToan'
      AND YEAR(DK.NgayDK) = 2025
      AND KH.CapDo = 'NangCao'
);

-- [SQL-4] "Đã có A nhưng chưa từng B" — Cách 1: EXCEPT
-- Kết quả kỳ vọng: GV02, GV03 (loại GV01, GV04 dù GV04 có PC09 là TroGiang CoBan!)
(
    SELECT GV.MaGV, GV.HoTenGV
    FROM GIANGVIEN GV
    JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
)
EXCEPT
(
    SELECT GV.MaGV, GV.HoTenGV
    FROM GIANGVIEN GV
    JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
    JOIN KHOAHOC KH ON PC.MaKH = KH.MaKH
    WHERE PC.VaiTro = 'GiangChinh'
      AND KH.CapDo = 'NangCao'
);

-- [SQL-4] Cách 2: NOT EXISTS
SELECT DISTINCT GV.MaGV, GV.HoTenGV
FROM GIANGVIEN GV
JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
WHERE NOT EXISTS (
    SELECT 1
    FROM PHANCONG_GD PC2
    JOIN KHOAHOC KH ON PC2.MaKH = KH.MaKH
    WHERE PC2.MaGV = GV.MaGV
      AND PC2.VaiTro = 'GiangChinh'
      AND KH.CapDo = 'NangCao'
);

-- [SQL-5] "Với mỗi khoa" — LEFT OUTER JOIN + điều kiện bảng phải đặt trong ON + COUNT(cột)
-- Kết quả kỳ vọng: KH01 (2, 5), KH02 (1, 1), KH03 (0, 0)
SELECT K.MaKhoa,
       K.TenKhoa,
       COUNT(KH.MaKH) AS SLKhoaNangCao,
       ISNULL(SUM(KH.SiSoHienTai), 0) AS TongSiSo
FROM KHOA K
LEFT OUTER JOIN KHOAHOC KH
       ON K.MaKhoa = KH.MaKhoa AND KH.CapDo = 'NangCao'
GROUP BY K.MaKhoa, K.TenKhoa;

-- [SQL-6] PHÉP CHIA SQL (8/8 đề CK) — Cách 1: NOT EXISTS 2 tầng
-- Kết quả kỳ vọng: HV01 (HV02 thiếu C03 dù học C02 và C04!)
SELECT HV.MaHV, HV.HoTenHV
FROM HOCVIEN HV
WHERE NOT EXISTS (
    SELECT 1
    FROM KHOAHOC KH
    WHERE KH.MaKhoa = 'KH01'
      AND KH.CapDo = 'NangCao'
      AND NOT EXISTS (
          SELECT 1
          FROM DANGKY DK
          WHERE DK.MaHV = HV.MaHV
            AND DK.MaKH = KH.MaKH
            AND DK.TinhTrangTT = 'DaThanhToan'
      )
);

-- [SQL-6] PHÉP CHIA SQL — Cách 2: GROUP BY ... HAVING COUNT(DISTINCT ...)
SELECT HV.MaHV, HV.HoTenHV
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
WHERE DK.TinhTrangTT = 'DaThanhToan'
  AND KH.MaKhoa = 'KH01'
  AND KH.CapDo = 'NangCao'
GROUP BY HV.MaHV, HV.HoTenHV
HAVING COUNT(DISTINCT KH.MaKH) = (
    SELECT COUNT(*)
    FROM KHOAHOC
    WHERE MaKhoa = 'KH01' AND CapDo = 'NangCao'
);

-- [SQL-7a] Thống kê với HAVING
-- Kết quả kỳ vọng: GV01 (48), GV02 (48)
SELECT GV.MaGV, GV.HoTenGV, SUM(PC.SoGioDay) AS TongGio
FROM GIANGVIEN GV
JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
JOIN KHOAHOC KH ON PC.MaKH = KH.MaKH
WHERE KH.TrangThai IN ('DangHoc', 'DaKetThuc')
GROUP BY GV.MaGV, GV.HoTenGV
HAVING SUM(PC.SoGioDay) > 40;

-- [SQL-7b] Cực trị toàn cục giữ đồng hạng — Cách 1: HAVING >= ALL
-- Kết quả kỳ vọng: HV01 (3), HV02 (3)
SELECT HV.MaHV, HV.HoTenHV, COUNT(DK.MaKH) AS SLKhoa
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
WHERE DK.TinhTrangTT = 'DaThanhToan'
GROUP BY HV.MaHV, HV.HoTenHV
HAVING COUNT(DK.MaKH) >= ALL (
    SELECT COUNT(MaKH)
    FROM DANGKY
    WHERE TinhTrangTT = 'DaThanhToan'
    GROUP BY MaHV
);

-- [SQL-7b] Cách 2: TOP 1 WITH TIES
SELECT TOP 1 WITH TIES HV.MaHV, HV.HoTenHV, COUNT(DK.MaKH) AS SLKhoa
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
WHERE DK.TinhTrangTT = 'DaThanhToan'
GROUP BY HV.MaHV, HV.HoTenHV
ORDER BY COUNT(DK.MaKH) DESC;

-- [SQL-8a] Cực trị theo từng nhóm (giống CK23 C1.2f) — giữ mức 0 và đồng hạng
-- Kết quả kỳ vọng: KH01 (GV01=2, GV03=2), KH02 (GV05=0), KH03 (GV06=0)
WITH ThongKe AS (
    SELECT GV.MaKhoa,
           GV.MaGV,
           GV.HoTenGV,
           COUNT(DISTINCT PC.MaKH) AS SLKhoaDay
    FROM GIANGVIEN GV
    LEFT OUTER JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
    GROUP BY GV.MaKhoa, GV.MaGV, GV.HoTenGV
)
SELECT T1.MaKhoa, T1.MaGV, T1.HoTenGV, T1.SLKhoaDay
FROM ThongKe T1
WHERE T1.SLKhoaDay <= ALL (
    SELECT T2.SLKhoaDay
    FROM ThongKe T2
    WHERE T2.MaKhoa = T1.MaKhoa
)
ORDER BY T1.MaKhoa, T1.MaGV;

-- [SQL-8b] Đối chiếu kín chỗ (giống CK24 C1.2f)
-- Kết quả kỳ vọng: C01 (3/3), C02 (2/2)
SELECT KH.MaKH, KH.TenKH, KH.SiSoToiDa
FROM KHOAHOC KH
JOIN DANGKY DK ON KH.MaKH = DK.MaKH
WHERE KH.MaKhoa = 'KH01'
  AND DK.TinhTrangTT <> 'DaHuy'
GROUP BY KH.MaKH, KH.TenKH, KH.SiSoToiDa
HAVING COUNT(DK.MaHV) >= KH.SiSoToiDa;
GO

/* ----------------------------------------------------------------------------
   PHẦN 4 (THAM KHẢO): MINH HỌA CÁC CÂU VIẾT SAI (BẪY ĐỀ THI)
   Bỏ comment để chạy thử và thấy rõ vì sao sai trên cùng tập dữ liệu trên!
   ---------------------------------------------------------------------------- */

/*
-- BẪY SQL-4: Dùng phủ định trực tiếp làm lọt nhầm GV04 (qua PC09)!
SELECT DISTINCT GV.MaGV, GV.HoTenGV
FROM GIANGVIEN GV
JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
JOIN KHOAHOC KH ON PC.MaKH = KH.MaKH
WHERE NOT (PC.VaiTro = 'GiangChinh' AND KH.CapDo = 'NangCao');

-- BẪY SQL-5: Đặt điều kiện bảng phải xuống WHERE làm mất khoa KH03 (0 khóa)!
SELECT K.MaKhoa, K.TenKhoa, COUNT(*) AS SLKhoaNangCao
FROM KHOA K
LEFT OUTER JOIN KHOAHOC KH ON K.MaKhoa = KH.MaKhoa
WHERE KH.CapDo = 'NangCao'
GROUP BY K.MaKhoa, K.TenKhoa;

-- BẪY SQL-6: Quên lọc KH.MaKhoa = 'KH01' ở truy vấn ngoài làm lọt nhầm HV02!
SELECT HV.MaHV, HV.HoTenHV
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
WHERE DK.TinhTrangTT = 'DaThanhToan' AND KH.CapDo = 'NangCao'
GROUP BY HV.MaHV, HV.HoTenHV
HAVING COUNT(DISTINCT KH.MaKH) = (
    SELECT COUNT(*) FROM KHOAHOC WHERE MaKhoa = 'KH01' AND CapDo = 'NangCao'
);
*/
