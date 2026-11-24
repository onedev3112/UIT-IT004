# Ngân hàng bài tập luyện phản xạ Cuối kỳ CSDL (tự soạn, có lời giải)

Soạn ngày 24/11/2026 để luyện phản xạ theo đầy đủ các dạng bài xuất hiện trong 8 mã đề `CK20–CK24` ([bản đồ đề CK](CK_BAN_DO_DE_THI_CSDL.md)). **Toàn bộ đề bài, lược đồ và bài tập bên dưới là câu tự soạn**, tách biệt hoàn toàn với 8 mã đề gốc và không dùng làm bằng chứng tần suất ra đề.

- **Cách luyện khuyên dùng:** Tự giải trọn **Phần I (Đề bài)** trên giấy hoặc chạy thử trực tiếp Phần B trên MS SQL Server bằng script đi kèm [CK_SQL_MAU_THUC_HANH.sql](CK_SQL_MAU_THUC_HANH.sql), sau đó mới kéo xuống đối chiếu với **Phần II (Lời giải chi tiết từng bước)**.
- Cú pháp SQL theo **MS SQL Server** (`T4 tr.41–95`).

---

# PHẦN I — ĐỀ BÀI TỰ LUYỆN

## Lược đồ dùng chung cho Phần A (RBTV) và Phần B (SQL)

Cho lược đồ CSDL **“Quản lý đào tạo & đăng ký khóa học ngắn hạn”** như sau (thuộc tính **in đậm** là khóa chính):

```text
KHOA (MaKhoa, TenKhoa, NhiemVu)
    PK: MaKhoa

GIANGVIEN (MaGV, HoTenGV, TrinhDo, MaKhoa)
    PK: MaGV
    FK: MaKhoa → KHOA(MaKhoa)

KHOAHOC (MaKH, TenKH, CapDo, HocPhi, SiSoToiDa, SiSoHienTai, TrangThai, MaKhoa)
    PK: MaKH
    FK: MaKhoa → KHOA(MaKhoa)

HOCVIEN (MaHV, HoTenHV, NgaySinh, ThanhPho)
    PK: MaHV

DANGKY (MaHV, MaKH, NgayDK, TinhTrangTT, DiemCuoiKhoa)
    PK: (MaHV, MaKH)
    FK: MaHV → HOCVIEN(MaHV), MaKH → KHOAHOC(MaKH)

PHANCONG_GD (MaPC, MaGV, MaKH, VaiTro, SoGioDay)
    PK: MaPC
    FK: MaGV → GIANGVIEN(MaGV), MaKH → KHOAHOC(MaKH)
```

**Tân từ và quy định nghiệp vụ:**
- `KHOA`: `NhiemVu` nhận `'DaoTaoChuyenSau'` hoặc `'ThucHanhUngDung'`.
- `GIANGVIEN`: `TrinhDo` nhận `'CuNhan'`, `'ThacSi'`, hoặc `'TienSi'`.
- `KHOAHOC`: `CapDo` nhận `'CoBan'`, `'TrungCap'`, `'NangCao'`; `TrangThai` nhận `'MoDangKy'`, `'DangHoc'`, `'DaKetThuc'` (**khi thêm mới một khóa học, `TrangThai` mặc định là `'MoDangKy'`**); `SiSoToiDa > 0`; `SiSoHienTai >= 0` (**khi thêm mới một khóa học, `SiSoHienTai` mặc định là `0`**).
- `DANGKY`: khóa chính ghép `(MaHV, MaKH)`. `TinhTrangTT` nhận `'DaThanhToan'`, `'ChuaThanhToan'`, hoặc `'DaHuy'`.
- `PHANCONG_GD`: khóa chính đơn `MaPC`. `VaiTro` nhận `'GiangChinh'` hoặc `'TroGiang'`; `SoGioDay > 0`.

---

## Phần A — Ràng buộc toàn vẹn (4 bài, đủ 4 nhóm đề CK) `[TRỌNG TÂM CK]`

Hãy phát biểu chặt chẽ từng ràng buộc toàn vẹn dưới đây (bao gồm đầy đủ: **bối cảnh**, **nội dung**, **bảng tầm ảnh hưởng**). **Lưu ý chung: Giá trị của thuộc tính khóa chính không sửa được.**

- **RBTV-1 *(Thuộc tính tổng hợp `=`, tương ứng `CK20` / `T5 tr.39`)*:** Sĩ số hiện tại (`SiSoHienTai`) của mỗi khóa học phải bằng số lượng lượt đăng ký chưa bị hủy (`TinhTrangTT <> 'DaHuy'`) của khóa học đó.
- **RBTV-2 *(Bất đẳng thức giới hạn `>= COUNT`, tương ứng `CK24-Đề2`)*:** Sĩ số tối đa (`SiSoToiDa`) của mỗi khóa học phải lớn hơn hoặc bằng số lượng học viên đã thanh toán (`TinhTrangTT = 'DaThanhToan'`) của khóa học đó.
- **RBTV-3 *(Liên bộ–liên quan hệ tối thiểu $k$, tương ứng `CK23`)*:** Khóa học cấp độ `'NangCao'` đang ở trạng thái `'DangHoc'` phải có tối thiểu `2` giảng viên phân biệt được phân công giảng dạy (`PHANCONG_GD`).
- **RBTV-4 *(Liên thuộc tính–liên quan hệ dạng cấm qua 3 bảng, tương ứng `CK22`)*:** Giảng viên có trình độ `'CuNhan'` KHÔNG được phân công giảng dạy các khóa học cấp độ `'NangCao'` với vai trò `'GiangChinh'`.

---

## Phần B — Truy vấn SQL (8 bài, đủ 6 dạng `C1.2a–f`) `[TRỌNG TÂM CK]`

Viết câu lệnh truy vấn **MS SQL Server** cho các yêu cầu sau (đã cài sẵn dữ liệu kiểm thử có *edge cases* tại [CK_SQL_MAU_THUC_HANH.sql](CK_SQL_MAU_THUC_HANH.sql)):

- **SQL-1 *(Dạng `a` — lọc, nối, `BETWEEN`, `ORDER BY`)*:** Liệt kê `MaKH`, `TenKH`, `HocPhi` và `TenKhoa` của các khóa học thuộc khoa có nhiệm vụ `'DaoTaoChuyenSau'` và có học phí từ `2.000.000` đến `5.000.000`. Sắp xếp kết quả theo `HocPhi` giảm dần, nếu bằng nhau thì theo `MaKH` tăng dần.
- **SQL-2 *(Dạng `b` — nối 3 bảng, hàm ngày/tháng/năm)*:** Liệt kê `MaHV`, `HoTenHV` và `TenKH` của các học viên có sinh nhật trong tháng `12`, đã đăng ký khóa học cấp độ `'NangCao'` trong năm `2025` với tình trạng `'DaThanhToan'`.
- **SQL-3 *(Dạng `c` — "cả hai", giao tập hợp)*:** Cho biết `MaHV`, `HoTenHV` của các học viên trong năm `2025` đã thanh toán (`'DaThanhToan'`) **cả hai** cấp độ khóa học `'CoBan'` và `'NangCao'`.
- **SQL-4 *(Dạng `c/d` — "có A nhưng chưa từng B", trừ tập hợp)*:** Cho biết `MaGV`, `HoTenGV` của các giảng viên đã từng được phân công giảng dạy nhưng **chưa từng** giữ vai trò `'GiangChinh'` cho bất kỳ khóa học cấp độ `'NangCao'` nào.
- **SQL-5 *(Dạng `d` — "với mỗi...", `LEFT JOIN` giữ số lượng `0`)*:** Với **mỗi khoa**, thống kê số lượng khóa học cấp độ `'NangCao'` và tổng sĩ số hiện tại của các khóa học đó (khoa chưa mở khóa `'NangCao'` nào vẫn hiển thị `0`). Hiển thị: `MaKhoa`, `TenKhoa`, `SLKhoaNangCao`, `TongSiSo`.
- **SQL-6 *(Dạng `e` — Phép chia SQL, 8/8 mã đề)*:** Tìm `MaHV`, `HoTenHV` của học viên đã thanh toán (`'DaThanhToan'`) **tất cả** các khóa học cấp độ `'NangCao'` do khoa có mã `'KH01'` mở.
- **SQL-7 *(Dạng `f` — `HAVING` & Cực trị toàn cục giữ đồng hạng)*:**
  - **7a:** Liệt kê `MaGV`, `HoTenGV` và tổng số giờ dạy (`TongGio`) của các giảng viên có tổng số giờ dạy các khóa ở trạng thái `'DangHoc'` hoặc `'DaKetThuc'` lớn hơn `40` giờ.
  - **7b:** Tìm `MaHV`, `HoTenHV` và số khóa học (`SLKhoa`) của các học viên có số khóa học đã thanh toán (`'DaThanhToan'`) **nhiều nhất**.
- **SQL-8 *(Dạng `f` nâng cao — Cực trị theo từng nhóm & Đối chiếu kín chỗ)*:**
  - **8a *(giống `CK23 C1.2f`)*:** Với **mỗi khoa**, tìm giảng viên (`MaKhoa`, `MaGV`, `HoTenGV`, `SLKhoaDay`) được phân công giảng dạy **ít khóa học nhất** (tính số khóa phân biệt; kể cả giảng viên chưa được phân công khóa nào, số lượng `0`).
  - **8b *(giống `CK24 C1.2f`)*:** Tìm các khóa học (`MaKH`, `TenKH`, `SiSoToiDa`) thuộc khoa `'KH01'` đã **được đăng ký kín chỗ** (số lượt đăng ký khác `'DaHuy'` lớn hơn hoặc bằng `SiSoToiDa`).

---

## Phần C — Phụ thuộc hàm, Khóa & Dạng chuẩn (4 bài phủ đủ 1NF → BCNF) `[TRỌNG TÂM CK]`

Với mỗi lược đồ quan hệ $R(U, F)$ dưới đây, thực hiện đủ 3 yêu cầu chuẩn Câu 2 đề Cuối kỳ:
1. Kiểm tra phụ thuộc hàm $f_{\text{test}}$ có là phụ thuộc hàm thành viên của $F^+$ không? Giải thích.
2. Tìm tất cả các khóa của $R(U, F)$. Giải thích.
3. Xác định **dạng chuẩn cao nhất** của $R(U, F)$. Giải thích.

- **Bài C2-1 *(có thuộc tính Treo $T \neq \emptyset$)*:**
  - $U = \{A, B, C, D, E, G, H\}$
  - $F = \{f_1: A \to C,\; f_2: CE \to B,\; f_3: B \to A,\; f_4: AD \to G\}$
  - $f_{\text{test}}$: $BE \to CG$
- **Bài C2-2:**
  - $U = \{A, B, C, D, E, G\}$
  - $F = \{f_1: AB \to CE,\; f_2: CB \to AE,\; f_3: E \to DG\}$
  - $f_{\text{test}}$: $CB \to DG$
- **Bài C2-3:**
  - $U = \{A, B, C, D, E\}$
  - $F = \{f_1: AB \to CDE,\; f_2: D \to B\}$
  - $f_{\text{test}}$: $AD \to CE$
- **Bài C2-4 *(trường hợp $N = \emptyset, T = \emptyset$)*:**
  - $U = \{A, B, C, D, E, G\}$
  - $F = \{f_1: AB \to CDEG,\; f_2: CD \to ABEG,\; f_3: AC \to BD\}$
  - $f_{\text{test}}$: $AC \to EG$

---
---

# PHẦN II — LỜI GIẢI CHI TIẾT TỪNG BƯỚC

## Lời giải Phần A — Ràng buộc toàn vẹn

### Bài RBTV-1
- **Bối cảnh:** `KHOAHOC`, `DANGKY`
- **Nội dung:**
  $$\forall kh \in \text{KHOAHOC},\; kh.\text{SiSoHienTai} = \text{COUNT}_{(dk \in \text{DANGKY} : dk.\text{MaKH} = kh.\text{MaKH} \land dk.\text{TinhTrangTT} \neq \text{'DaHuy'})}(*)$$
- **Bảng tầm ảnh hưởng:**

| RBTV-1 | Thêm | Xóa | Sửa |
|---|---|---|---|
| `KHOAHOC` | `-(*)` | `-` | `+(SiSoHienTai)` |
| `DANGKY` | `+` | `+` | `+(TinhTrangTT)` |

- **Giải thích chú thích & bẫy:**
  - `-(*)` tại (`KHOAHOC`, Thêm): Theo tân từ, khi thêm mới khóa học thì `SiSoHienTai` mặc định bằng `0`, khớp với số lượng đăng ký ban đầu bằng `0` (`T5 tr.39`). *(Nếu đề không quy định mặc định `= 0` thì ghi `+`.)*
  - Tại (`DANGKY`, Sửa): Không ghi `MaKH` vào `+(...)` vì `(MaHV, MaKH)` là **khóa chính ghép** của `DANGKY` và đề quy định không được sửa khóa chính; chỉ sửa `TinhTrangTT` (chuyển từ `'DaHuy'` sang khác `'DaHuy'` hoặc ngược lại) mới làm thay đổi số đếm.

---

### Bài RBTV-2
- **Bối cảnh:** `KHOAHOC`, `DANGKY`
- **Nội dung:**
  $$\forall kh \in \text{KHOAHOC},\; kh.\text{SiSoToiDa} \ge \text{COUNT}_{(dk \in \text{DANGKY} : dk.\text{MaKH} = kh.\text{MaKH} \land dk.\text{TinhTrangTT} = \text{'DaThanhToan'})}(*)$$
- **Bảng tầm ảnh hưởng:**

| RBTV-2 | Thêm | Xóa | Sửa |
|---|---|---|---|
| `KHOAHOC` | `-(*)` | `-` | `+(SiSoToiDa)` |
| `DANGKY` | `+` | `-` | `+(TinhTrangTT)` |

- **Giải thích chú thích & bẫy:**
  - `-(*)` tại (`KHOAHOC`, Thêm): Tân từ quy định `SiSoToiDa > 0`; khi mới thêm khóa học chưa có lượt đăng ký nào (`COUNT = 0`), nên `SiSoToiDa >= 0` luôn đúng.
  - (`DANGKY`, Xóa) là **`-`** (khác RBTV-1!) vì bất đẳng thức là `>=`: xóa bớt 1 đăng ký chỉ làm giảm vế phải nên không vi phạm.
  - (`DANGKY`, Sửa): `MaKH` thuộc khóa chính ghép không sửa được; sửa `TinhTrangTT` thành `'DaThanhToan'` làm tăng vế phải nên ghi `+(TinhTrangTT)`.

---

### Bài RBTV-3
- **Bối cảnh:** `KHOAHOC`, `PHANCONG_GD`
- **Nội dung:**
  $$\forall kh \in \text{KHOAHOC} : (kh.\text{CapDo} = \text{'NangCao'} \land kh.\text{TrangThai} = \text{'DangHoc'}) \implies \text{COUNT}_{(pc \in \text{PHANCONG\_GD} : pc.\text{MaKH} = kh.\text{MaKH})}(\text{DISTINCT } pc.\text{MaGV}) \ge 2$$
- **Bảng tầm ảnh hưởng:**

| RBTV-3 | Thêm | Xóa | Sửa |
|---|---|---|---|
| `KHOAHOC` | `-(*)` | `-` | `+(CapDo, TrangThai)` |
| `PHANCONG_GD` | `-` | `+` | `+(MaKH, MaGV)` |

- **Giải thích chú thích & bẫy:**
  - `-(*)` tại (`KHOAHOC`, Thêm): Theo tân từ, khi thêm khóa học mới thì `TrangThai` mặc định là `'MoDangKy'` (chưa phải `'DangHoc'`), nên điều kiện tiền đề sai và ràng buộc không bị vi phạm.
  - (`PHANCONG_GD`, Thêm) là `-` (thêm phân công chỉ tăng/giữ nguyên số giảng viên); (`PHANCONG_GD`, Xóa) là **`+`** (xóa phân công có thể làm số giảng viên tụt xuống $< 2$).
  - (`PHANCONG_GD`, Sửa): Khóa chính của `PHANCONG_GD` là khóa đơn `MaPC`, nên cả `MaKH` lẫn `MaGV` **đều không phải khóa chính và vẫn sửa được**! Sửa `MaKH` làm rút giảng viên khỏi khóa học cũ; sửa `MaGV` thành mã trùng giảng viên còn lại làm giảm số giảng viên phân biệt xuống $1 < 2$.

---

### Bài RBTV-4
- **Bối cảnh:** `GIANGVIEN`, `KHOAHOC`, `PHANCONG_GD` *(đủ cả 3 bảng!)*
- **Nội dung:**
  $$\forall pc \in \text{PHANCONG\_GD},\; \forall gv \in \text{GIANGVIEN},\; \forall kh \in \text{KHOAHOC} :$$
  $$(pc.\text{MaGV} = gv.\text{MaGV} \land pc.\text{MaKH} = kh.\text{MaKH} \land gv.\text{TrinhDo} = \text{'CuNhan'} \land kh.\text{CapDo} = \text{'NangCao'}) \implies pc.\text{VaiTro} \neq \text{'GiangChinh'}$$
  *(Hoặc tương đương: $\neg \exists pc \in \text{PHANCONG\_GD},\; \exists gv \in \text{GIANGVIEN},\; \exists kh \in \text{KHOAHOC} : pc.\text{MaGV} = gv.\text{MaGV} \land pc.\text{MaKH} = kh.\text{MaKH} \land gv.\text{TrinhDo} = \text{'CuNhan'} \land kh.\text{CapDo} = \text{'NangCao'} \land pc.\text{VaiTro} = \text{'GiangChinh'}$.)*
- **Bảng tầm ảnh hưởng:**

| RBTV-4 | Thêm | Xóa | Sửa |
|---|---|---|---|
| `GIANGVIEN` | `-` | `-` | `+(TrinhDo)` |
| `KHOAHOC` | `-` | `-` | `+(CapDo)` |
| `PHANCONG_GD` | `+` | `-` | `+(MaGV, MaKH, VaiTro)` |

- **Giải thích:** Thêm mới giảng viên hoặc khóa học chưa có dòng tương ứng trong `PHANCONG_GD` nên `-`. Sửa `TrinhDo` thành `'CuNhan'`, sửa `CapDo` thành `'NangCao'`, hoặc thêm/sửa `MaGV, MaKH, VaiTro` trên `PHANCONG_GD` (cả 3 đều không thuộc khóa chính `MaPC`) đều có thể tạo ra tổ hợp bị cấm.

---

## Lời giải Phần B — Truy vấn SQL (MS SQL Server)

*(Các kết quả đối chiếu bên dưới khớp chính xác với tập dữ liệu kiểm thử trong [CK_SQL_MAU_THUC_HANH.sql](CK_SQL_MAU_THUC_HANH.sql).)*

### SQL-1
```sql
SELECT KH.MaKH, KH.TenKH, KH.HocPhi, K.TenKhoa
FROM KHOAHOC KH
JOIN KHOA K ON KH.MaKhoa = K.MaKhoa
WHERE K.NhiemVu = 'DaoTaoChuyenSau'
  AND KH.HocPhi BETWEEN 2000000 AND 5000000
ORDER BY KH.HocPhi DESC, KH.MaKH ASC;
```
*Kết quả trên dữ liệu mẫu:* `C03 (5.000.000)`, `C02 (4.500.000)`, `C01 (2.500.000)`.

### SQL-2
```sql
SELECT HV.MaHV, HV.HoTenHV, KH.TenKH
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
JOIN KHOAHOC KH ON DK.MaKH = KH.MaKH
WHERE MONTH(HV.NgaySinh) = 12
  AND KH.CapDo = 'NangCao'
  AND YEAR(DK.NgayDK) = 2025
  AND DK.TinhTrangTT = 'DaThanhToan';
```
*Kết quả trên dữ liệu mẫu:* `(HV01, C02)`, `(HV01, C03)`, `(HV02, C02)`, `(HV02, C04)`.

### SQL-3 *(2 cách tương đương)*

**Cách 1 — `INTERSECT` (`T4 tr.65`):**
```sql
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
```

**Cách 2 — Hai `EXISTS` (`T4 tr.71`):**
```sql
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
```
*Kết quả trên dữ liệu mẫu:* `HV01`, `HV02`, `HV04` (`HV03` bị loại vì khóa `NangCao` bị `DaHuy` / `ChuaThanhToan`).

### SQL-4 *(2 cách tương đương — tránh bẫy `<>`)*

**Cách 1 — `EXCEPT` (`T4 tr.66`):**
```sql
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
```

**Cách 2 — `NOT EXISTS` (`T4 tr.74`):**
```sql
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
```
*Bẫy đã cài trong dữ liệu mẫu:* `GV04` vừa là `'GiangChinh'` khóa `'NangCao'` (`C04`), vừa là `'TroGiang'` khóa `'CoBan'` (`C05`). Nếu viết sai bằng điều kiện `WHERE NOT (VaiTro = 'GiangChinh' AND CapDo = 'NangCao')`, `GV04` sẽ bị lọt nhầm vào kết quả. Kết quả đúng chỉ gồm `GV02` và `GV03` (`GV05`, `GV06` chưa từng được phân công nên cũng không nằm trong tập ứng viên).

### SQL-5 *(tránh bẫy `LEFT JOIN` + `WHERE` và `COUNT(*)`)*
```sql
SELECT K.MaKhoa,
       K.TenKhoa,
       COUNT(KH.MaKH) AS SLKhoaNangCao,
       ISNULL(SUM(KH.SiSoHienTai), 0) AS TongSiSo
FROM KHOA K
LEFT OUTER JOIN KHOAHOC KH
       ON K.MaKhoa = KH.MaKhoa AND KH.CapDo = 'NangCao'
GROUP BY K.MaKhoa, K.TenKhoa;
```
*Kết quả trên dữ liệu mẫu:* `KH01 (2, 5)`, `KH02 (1, 1)`, `KH03 (0, 0)`. (Nếu đặt `KH.CapDo = 'NangCao'` xuống `WHERE` sẽ mất dòng `KH03`; nếu dùng `COUNT(*)` sẽ đếm nhầm `KH03` thành `1`.)

### SQL-6 — Phép chia SQL *(2 cách chuẩn `T4`)* `[TRỌNG TÂM CK]`

**Cách 1 — `NOT EXISTS` 2 tầng (`T4 tr.80`):**
```sql
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
```

**Cách 2 — `GROUP BY ... HAVING COUNT(DISTINCT ...)` (`T4 tr.92`):**
```sql
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
```
*Bẫy đã cài trong dữ liệu mẫu:* `KH01` có 2 khóa `'NangCao'` là `C02` và `C03`. `HV02` học 2 khóa `'NangCao'` (`C02` của `KH01` và `C04` của `KH02`) — nếu ở Cách 2 quên lọc `KH.MaKhoa = 'KH01'` ở truy vấn ngoài, `HV02` sẽ bị nhận nhầm là đạt phép chia! Kết quả đúng duy nhất là `HV01`.

### SQL-7

**7a (`HAVING`):**
```sql
SELECT GV.MaGV, GV.HoTenGV, SUM(PC.SoGioDay) AS TongGio
FROM GIANGVIEN GV
JOIN PHANCONG_GD PC ON GV.MaGV = PC.MaGV
JOIN KHOAHOC KH ON PC.MaKH = KH.MaKH
WHERE KH.TrangThai IN ('DangHoc', 'DaKetThuc')
GROUP BY GV.MaGV, GV.HoTenGV
HAVING SUM(PC.SoGioDay) > 40;
```
*Kết quả trên dữ liệu mẫu:* `GV01 (48)`, `GV02 (48)`.

**7b (Cực trị toàn cục giữ đồng hạng — 2 cách `T4 tr.89–90`):**
```sql
-- Cách 1: HAVING >= ALL
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

-- Cách 2: TOP 1 WITH TIES (chuẩn MS SQL Server)
SELECT TOP 1 WITH TIES HV.MaHV, HV.HoTenHV, COUNT(DK.MaKH) AS SLKhoa
FROM HOCVIEN HV
JOIN DANGKY DK ON HV.MaHV = DK.MaHV
WHERE DK.TinhTrangTT = 'DaThanhToan'
GROUP BY HV.MaHV, HV.HoTenHV
ORDER BY COUNT(DK.MaKH) DESC;
```
*Kết quả trên dữ liệu mẫu:* đồng hạng cả `HV01 (3)` và `HV02 (3)`.

### SQL-8

**8a (Cực trị theo từng nhóm — giữ cả số lượng `0` và đồng hạng):**
```sql
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
```
*Kết quả trên dữ liệu mẫu:* `KH01: GV01 (2), GV03 (2)` (đồng hạng trong cùng khoa), `KH02: GV05 (0)`, `KH03: GV06 (0)`.

**8b (Đối chiếu kín chỗ):**
```sql
SELECT KH.MaKH, KH.TenKH, KH.SiSoToiDa
FROM KHOAHOC KH
JOIN DANGKY DK ON KH.MaKH = DK.MaKH
WHERE KH.MaKhoa = 'KH01'
  AND DK.TinhTrangTT <> 'DaHuy'
GROUP BY KH.MaKH, KH.TenKH, KH.SiSoToiDa
HAVING COUNT(DK.MaHV) >= KH.SiSoToiDa;
```
*Kết quả trên dữ liệu mẫu:* `C01 (3/3)`, `C02 (2/2)` (`C02` có 1 lượt `'DaHuy'` bị loại trước khi đếm; `C03` mới `3/4` nên chưa kín).

---

## Lời giải Phần C — Phụ thuộc hàm, Khóa & Dạng chuẩn

### Bài C2-1 — $U = \{A,B,C,D,E,G,H\}$, $F = \{f_1: A \to C,\; f_2: CE \to B,\; f_3: B \to A,\; f_4: AD \to G\}$

**1. Kiểm tra $BE \to CG \in F^+$:**
- $(BE)^+_F = BE$
- $(BE)^+_F = BEA$ (vì $f_3: B \to A$)
- $(BE)^+_F = BEAC = ABCE$ (vì $f_1: A \to C$)
- Quét lại toàn bộ $F$ không nạp thêm được thuộc tính nào nữa. Vậy $(BE)^+_F = ABCE$.
- Vì $G \notin (BE)^+_F$ nên $CG \not\subseteq (BE)^+_F$. **Kết luận:** $BE \to CG \notin F^+$.

**2. Tìm tất cả các khóa của $R(U, F)$:**
- Phân hoạch $U$:
  - Tập thuộc tính treo: $T = \{H\}$ *(chú ý $H \in U$ nhưng không xuất hiện trong $F$!)*.
  - Tập thuộc tính nguồn: $N = \{D, E\}$.
  - Tập thuộc tính trung gian: $TG = \{A, B, C\}$.
  - Tập thuộc tính đích: $\text{Đ} = \{G\}$. *(Kiểm tổng: $1+2+3+1 = 7 = |U|$.)*
- **Bước 1:** $N \cup T = DEH$. Tính $(DEH)^+_F = DEH \neq U \implies$ chuyển Bước 2.
- **Bước 2:** $CTG = \{A, B, C, AB, AC, BC, ABC\}$.
- **Bước 3:**

| $N \cup T$ | $X_i$ | $N \cup T \cup X_i$ | $(N \cup T \cup X_i)^+_F$ và Kết luận |
|---|---|---|---|
| $DEH$ | $A$ | $ADEH$ | $ADEH \xrightarrow{f_1} ACDEH \xrightarrow{f_2} ABCDEH \xrightarrow{f_4} ABCDEGH = U \implies$ **Khóa là $ADEH$**. Loại các tập chứa $A$: $AB, AC, ABC$. |
| $DEH$ | $B$ | $BDEH$ | $BDEH \xrightarrow{f_3} ABDEH \xrightarrow{f_1} ABCDEH \xrightarrow{f_4} ABCDEGH = U \implies$ **Khóa là $BDEH$**. Loại các tập chứa $B$: $BC$. |
| $DEH$ | $C$ | $CDEH$ | $CDEH \xrightarrow{f_2} BCDEH \xrightarrow{f_3} ABCDEH \xrightarrow{f_4} ABCDEGH = U \implies$ **Khóa là $CDEH$**. |

- **Kết luận:** Tập tất cả các khóa là $S = \{ADEH,\; BDEH,\; CDEH\}$.
  - Thuộc tính khóa ($\text{TTK}$): $\{A, B, C, D, E, H\}$.
  - Thuộc tính không khóa ($\text{TTKK}$): $\{G\}$.

**3. Xác định dạng chuẩn cao nhất của $R(U, F)$:**
- **Kiểm BCNF:** Xét $f_1: A \to C$ (hoặc $f_4: AD \to G$) có vế trái không là siêu khóa $\implies$ **không đạt BCNF**.
- **Kiểm 3NF:** Xét $f_4: AD \to G$: $AD$ không là siêu khóa và $G \in \text{TTKK}$ (không là thuộc tính khóa) $\implies$ **không đạt 3NF**.
- **Kiểm 2NF:** Xét khóa $K = ADEH$ và tập con thực sự $S_1 = AD \subset ADEH$. Ta có $(AD)^+_F = ACDG \ni G$, trong đó $G$ là thuộc tính không khóa (thuộc tính không khóa $G$ phụ thuộc riêng phần vào khóa $ADEH$) $\implies$ **không đạt 2NF**.
- **Kết luận:** Dạng chuẩn cao nhất của $R$ là **1NF**.

---

### Bài C2-2 — $U = \{A,B,C,D,E,G\}$, $F = \{f_1: AB \to CE,\; f_2: CB \to AE,\; f_3: E \to DG\}$

**1. Kiểm tra $CB \to DG \in F^+$:**
- $(CB)^+_F = CB$
- $(CB)^+_F = CBAE = ABCE$ (vì $f_2: CB \to AE$)
- $(CB)^+_F = ABCEDG = ABCDEG$ (vì $f_3: E \to DG$)
- Vì $DG \subseteq (CB)^+_F$ nên **Kết luận:** $CB \to DG \in F^+$.

**2. Tìm tất cả các khóa của $R(U, F)$:**
- $T = \emptyset$, $N = \{B\}$, $TG = \{A, C, E\}$, $\text{Đ} = \{D, G\}$. *(Kiểm tổng: $0+1+3+2 = 6 = |U|$.)*
- **Bước 1:** $(N \cup T)^+_F = B^+_F = B \neq U \implies$ chuyển Bước 2.
- **Bước 2:** $CTG = \{A, C, E, AC, AE, CE, ACE\}$.
- **Bước 3:**

| $N \cup T$ | $X_i$ | $N \cup T \cup X_i$ | $(N \cup T \cup X_i)^+_F$ và Kết luận |
|---|---|---|---|
| $B$ | $A$ | $AB$ | $AB \xrightarrow{f_1} ABCE \xrightarrow{f_3} ABCDEG = U \implies$ **Khóa là $AB$**. Loại: $AC, AE, ACE$. |
| $B$ | $C$ | $BC$ | $BC \xrightarrow{f_2} ABCE \xrightarrow{f_3} ABCDEG = U \implies$ **Khóa là $BC$**. Loại: $CE$. |
| $B$ | $E$ | $BE$ | $BE \xrightarrow{f_3} BDEG \neq U$. |

- **Kết luận:** Tập tất cả các khóa là $S = \{AB,\; BC\}$.
  - $\text{TTK} = \{A, B, C\}$; $\text{TTKK} = \{D, E, G\}$.

**3. Xác định dạng chuẩn cao nhất của $R(U, F)$:**
- Tách vế phải $F$: $AB \to C$, $AB \to E$, $CB \to A$, $CB \to E$, $E \to D$, $E \to G$.
- **Kiểm BCNF:** Xét $E \to D$: $E$ không là siêu khóa $\implies$ **không đạt BCNF**.
- **Kiểm 3NF:** Xét $E \to D$: $E$ không là siêu khóa và $D \in \text{TTKK}$ $\implies$ **không đạt 3NF**.
- **Kiểm 2NF:** Các tập con thực sự khác rỗng của hai khóa $AB$ và $BC$ là $A$, $B$, $C$. Tính bao đóng từng tập:
  - $A^+_F = A$ (không chứa thuộc tính không khóa $D, E, G$).
  - $B^+_F = B$ (không chứa thuộc tính không khóa $D, E, G$).
  - $C^+_F = C$ (không chứa thuộc tính không khóa $D, E, G$).
  - Mọi thuộc tính không khóa đều phụ thuộc đầy đủ vào mọi khóa $\implies$ **đạt 2NF**.
- **Kết luận:** Dạng chuẩn cao nhất của $R$ là **2NF**.

---

### Bài C2-3 — $U = \{A,B,C,D,E\}$, $F = \{f_1: AB \to CDE,\; f_2: D \to B\}$

**1. Kiểm tra $AD \to CE \in F^+$:**
- $(AD)^+_F = AD$
- $(AD)^+_F = ADB$ (vì $f_2: D \to B$)
- $(AD)^+_F = ABCDE$ (vì $f_1: AB \to CDE$)
- Vì $CE \subseteq (AD)^+_F$ nên **Kết luận:** $AD \to CE \in F^+$.

**2. Tìm tất cả các khóa của $R(U, F)$:**
- $T = \emptyset$, $N = \{A\}$, $TG = \{B, D\}$, $\text{Đ} = \{C, E\}$. *(Kiểm tổng: $0+1+2+2 = 5 = |U|$.)*
- **Bước 1:** $(N \cup T)^+_F = A^+_F = A \neq U \implies$ chuyển Bước 2.
- **Bước 2:** $CTG = \{B, D, BD\}$.
- **Bước 3:**

| $N \cup T$ | $X_i$ | $N \cup T \cup X_i$ | $(N \cup T \cup X_i)^+_F$ và Kết luận |
|---|---|---|---|
| $A$ | $B$ | $AB$ | $AB \xrightarrow{f_1} ABCDE = U \implies$ **Khóa là $AB$**. Loại: $BD$. |
| $A$ | $D$ | $AD$ | $AD \xrightarrow{f_2} ABD \xrightarrow{f_1} ABCDE = U \implies$ **Khóa là $AD$**. |

- **Kết luận:** Tập tất cả các khóa là $S = \{AB,\; AD\}$.
  - $\text{TTK} = \{A, B, D\}$; $\text{TTKK} = \{C, E\}$.

**3. Xác định dạng chuẩn cao nhất của $R(U, F)$:**
- Tách vế phải $F$: $AB \to C$, $AB \to D$, $AB \to E$, $D \to B$.
- **Kiểm BCNF:** Xét $D \to B$: vế trái $D$ không chứa khóa nào ($D$ không là siêu khóa) $\implies$ **không đạt BCNF**.
- **Kiểm 3NF:** Xét tất cả PTH không tầm thường sau khi tách:
  - $AB \to C$, $AB \to D$, $AB \to E$: đều có vế trái $AB$ là **siêu khóa** (thỏa điều kiện 1).
  - $D \to B$: có vế phải $B \in \text{TTK}$ là **thuộc tính khóa** (thỏa điều kiện 2).
  - Mọi PTH đều thỏa tiêu chí 3NF $\implies$ **đạt 3NF**.
- **Kết luận:** Dạng chuẩn cao nhất của $R$ là **3NF**.

---

### Bài C2-4 — $U = \{A,B,C,D,E,G\}$, $F = \{f_1: AB \to CDEG,\; f_2: CD \to ABEG,\; f_3: AC \to BD\}$

**1. Kiểm tra $AC \to EG \in F^+$:**
- $(AC)^+_F = AC$
- $(AC)^+_F = ABCD$ (vì $f_3: AC \to BD$)
- $(AC)^+_F = ABCDEG$ (vì $f_1: AB \to CDEG$)
- Vì $EG \subseteq (AC)^+_F$ nên **Kết luận:** $AC \to EG \in F^+$.

**2. Tìm tất cả các khóa của $R(U, F)$:**
- $T = \emptyset$, $N = \emptyset$, $TG = \{A, B, C, D\}$, $\text{Đ} = \{E, G\}$. *(Kiểm tổng: $0+0+4+2 = 6 = |U|$.)*
- **Bước 1:** $N \cup T = \emptyset \implies$ chuyển Bước 2.
- **Bước 2:** $CTG = \{A, B, C, D,\; AB, AC, AD, BC, BD, CD,\; ABC, ABD, ACD, BCD,\; ABCD\}$.
- **Bước 3:**

| $N \cup T$ | $X_i$ | $N \cup T \cup X_i$ | $(N \cup T \cup X_i)^+_F$ và Kết luận |
|---|---|---|---|
| $\emptyset$ | $A$ | $A$ | $A \neq U$ |
| $\emptyset$ | $B$ | $B$ | $B \neq U$ |
| $\emptyset$ | $C$ | $C$ | $C \neq U$ |
| $\emptyset$ | $D$ | $D$ | $D \neq U$ |
| $\emptyset$ | $AB$ | $AB$ | $AB \xrightarrow{f_1} ABCDEG = U \implies$ **Khóa là $AB$**. Loại: $ABC, ABD, ABCD$. |
| $\emptyset$ | $AC$ | $AC$ | $AC \xrightarrow{f_3} ABCD \xrightarrow{f_1} ABCDEG = U \implies$ **Khóa là $AC$**. Loại: $ACD$. |
| $\emptyset$ | $AD$ | $AD$ | $AD \neq U$ |
| $\emptyset$ | $BC$ | $BC$ | $BC \neq U$ |
| $\emptyset$ | $BD$ | $BD$ | $BD \neq U$ |
| $\emptyset$ | $CD$ | $CD$ | $CD \xrightarrow{f_2} ABCDEG = U \implies$ **Khóa là $CD$**. Loại: $BCD$. |

- **Kết luận:** Tập tất cả các khóa là $S = \{AB,\; AC,\; CD\}$.
  - $\text{TTK} = \{A, B, C, D\}$; $\text{TTKK} = \{E, G\}$.

**3. Xác định dạng chuẩn cao nhất của $R(U, F)$:**
- Tách vế phải $F$: mọi PTH không tầm thường đều có vế trái thuộc $\{AB,\; CD,\; AC\}$.
- **Kiểm BCNF:** Cả ba vế trái $AB$, $CD$, $AC$ đều là khóa (nên đều là **siêu khóa**) $\implies$ **đạt BCNF**.
- **Kết luận:** Dạng chuẩn cao nhất của $R$ là **BCNF**.
