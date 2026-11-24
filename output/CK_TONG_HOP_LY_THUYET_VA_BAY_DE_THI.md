# Tổng hợp Lý thuyết trọng tâm & Bẫy đề thi Cuối kỳ CSDL

Soạn ngày 24/11/2026 bám sát 3 nguồn lý thuyết Cuối kỳ: [T4 — Chương 4 (tr.41–95)](<../Lý thuyết/DPL_Chuong 4 - SQL.pdf>), [T5 — Chương 5 (tr.1–53)](<../Lý thuyết/DPL_Chuong 5 - Rang buoc toan ven.pdf>), [T6 — Chương 6 (tr.1–87)](<../Lý thuyết/DPL_Chuong 6 - Dang chuan.pdf>) và đối chiếu tần suất trên 8 mã đề `CK24`, `CK23`, `CK22`, `CK20` ([bản đồ đề CK](CK_BAN_DO_DE_THI_CSDL.md)). Cú pháp SQL theo **MS SQL Server**.

Các mục gắn thẻ `[TRỌNG TÂM CK]` là phần xuất hiện trực tiếp, lặp dày đặc trong 8/8 mã đề Cuối kỳ.

---

## Phần 1 — Chương 4 (tr.41–95): Ngôn ngữ truy vấn dữ liệu SQL `[TRỌNG TÂM CK]`

Chiếm **6,0 / 10 điểm (60%)** ở cả 8/8 mã đề Cuối kỳ (`C1.2a–f`).

### 1.1. Cú pháp tổng quát & Thứ tự thực thi logic (`T4 tr.42–43, 82–90`)

```sql
SELECT [DISTINCT] [TOP n [WITH TIES]] <cột / hàm tổng hợp / biểu thức>
FROM <bảng> [INNER | LEFT | RIGHT | FULL OUTER] JOIN <bảng> ON <điều kiện nối>
[WHERE <điều kiện lọc trên từng dòng>]
[GROUP BY <danh sách cột gom nhóm>]
[HAVING <điều kiện lọc trên từng nhóm>]
[ORDER BY <cột / biểu thức> [ASC | DESC]];
```

**Thứ tự đánh giá logic của SQL Server** (khác thứ tự viết):

$$\text{FROM / JOIN} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{SELECT [DISTINCT]} \longrightarrow \text{ORDER BY} \longrightarrow \text{TOP}$$

- Vì `WHERE` chạy trước `SELECT` nên **không dùng alias định nghĩa ở `SELECT` trong `WHERE` hay `GROUP BY`**.
- Vì `WHERE` chạy trước `GROUP BY` nên **không đặt hàm tổng hợp (`COUNT`, `SUM`...) trong `WHERE`**; điều kiện trên kết quả gom nhóm bắt buộc đặt ở `HAVING`.

### 1.2. Sáu nhóm truy vấn trọng tâm theo `T4`

| Nhóm truy vấn | Trang T4 | Cú pháp / Toán tử chính | Vai trò trong đề CK |
|---|---:|---|---|
| **1. Toán tử & hàm** | 46–47 | `=`, `<>`, `BETWEEN ... AND ...`, `IN`, `IS [NOT] NULL`, `LIKE '%_'`, `DAY()`, `MONTH()`, `YEAR()`, `LEFT/RIGHT/SUBSTRING/UPPER/LOWER` | Lọc ngày/tháng/năm, khoảng giá trị, chuỗi Unicode `N'...'` |
| **2. Truy vấn cơ bản & Kết bằng** `[TRỌNG TÂM CK]` | 48–62 | `SELECT`, `DISTINCT`, `AS`, `INNER JOIN ... ON` (hoặc liệt kê bảng ở `FROM`, nối ở `WHERE`), `ORDER BY ... ASC/DESC` | **8/8 đề** ở ý `a`, `b` (nối 2–3 bảng, lọc mốc thời gian, sắp xếp) |
| **3. Phép toán tập hợp** `[TRỌNG TÂM CK]` | 63–67 | `UNION` (hội), `INTERSECT` (giao), `EXCEPT` (trừ). Hai câu phải **khả hợp** (cùng số cột, tương thích kiểu dữ liệu) và tự loại trùng | **8/8 đề** ở ý `c` hoặc `d` (*"cả hai"*, *"có A nhưng không B"*, *"chưa từng"*) |
| **4. Truy vấn lồng** `[TRỌNG TÂM CK]` | 68–81 | `[NOT] IN`, `[NOT] EXISTS`, `<so sánh> ANY / ALL`, **phép chia 2 tầng `NOT EXISTS ... NOT EXISTS`** | Ý `c/d` (giao/trừ), **8/8 đề ở ý `e` (phép chia)**, ý `f` (cực trị `>= ALL` / `<= ALL`) |
| **5. Hàm nhóm & `GROUP BY / HAVING`** `[TRỌNG TÂM CK]` | 82–92 | `COUNT(*)`, `COUNT(col)`, `COUNT(DISTINCT col)`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`, `TOP n [WITH TIES]`, phép chia bằng `HAVING COUNT(...) = (SELECT COUNT(...) ...)` | **8/8 đề** ở ý `c/d` (thống kê) và ý `f` (`HAVING`, cực trị, đặt hết vé) |
| **6. Phép kết ngoài** | 93–95 | `LEFT OUTER JOIN`, `RIGHT OUTER JOIN`, `FULL OUTER JOIN` | Giữ đối tượng có số lượng `0` (*"với mỗi..."*), hoặc phủ định (`WHERE B.Khoa IS NULL`) |

### 1.3. Mười bẫy SQL rất dễ mất điểm trong đề UIT `[TRỌNG TÂM CK]`

1. **Bẫy `AND` cùng một cột trên 1 dòng khi đề hỏi *"cả A và B"*:**
   - Ví dụ: *"đặt cả hạng ghế Thương gia và Phổ thông"* (`CK24-Đề1 C1.2c`). Một dòng chi tiết chỉ có 1 hạng ghế nên `HangGhe = N'Thương gia' AND HangGhe = N'Phổ thông'` **luôn trả về rỗng**.
   - **Cách đúng:** Dùng `INTERSECT`, `IN`, hoặc 2 `EXISTS` (hoặc `GROUP BY ... HAVING COUNT(DISTINCT HangGhe) = 2`).
2. **Bẫy phủ định `<>` thay cho *"chưa từng / không có bất kỳ"*:**
   - Ví dụ: *"đã công bố bài báo nhưng không là tác giả chính của bất kỳ bài nào"* (`CK23-Đề1 C1.2c`). Nếu viết `WHERE VaiTroBB <> N'tác giả chính'`, nhân viên vừa là tác giả chính bài 1 vừa là đồng tác giả bài 2 **vẫn bị lọt vào kết quả**.
   - **Cách đúng:** Dùng `EXCEPT` hoặc `NOT EXISTS` (lấy tập ứng viên trừ tập có ít nhất 1 dòng vi phạm).
3. **Bẫy `NOT IN` khi truy vấn con có khả năng chứa `NULL`:**
   - Trong logic 3 giá trị của SQL, `x NOT IN (1, NULL)` luôn cho `UNKNOWN` → câu truy vấn **trả về rỗng hoàn toàn**.
   - **Cách đúng:** Ưu tiên `NOT EXISTS` hoặc `EXCEPT`; nếu dùng `NOT IN` phải chắc chắn cột không `NULL` (hoặc thêm `WHERE col IS NOT NULL` ở truy vấn con).
4. **Bẫy `LEFT JOIN` đặt điều kiện lọc bảng phải ở `WHERE`:**
   - Khi lọc `WHERE YEAR(DV.ThoiGianDV) = 2024` sau `LEFT JOIN DATVE DV`, các dòng `NULL` bên phải bị loại bỏ → **`LEFT JOIN` biến thành `INNER JOIN`**, mất toàn bộ đối tượng có số lượng `0`.
   - **Cách đúng:** Đặt điều kiện lọc của bảng phải vào mệnh đề `ON` hoặc lọc trước trong bảng con (`LEFT JOIN (SELECT ... WHERE ...) T ON ...`).
5. **Bẫy `COUNT(*)` sau `LEFT JOIN`:**
   - `COUNT(*)` đếm cả dòng có giá trị `NULL` đệm bên phải thành `1` thay vì `0`.
   - **Cách đúng:** Dùng `COUNT(BangPhai.Khoa)` (hàm `COUNT(col)` bỏ qua `NULL`), hoặc `ISNULL(SUM(BangPhai.SL), 0)` khi tính tổng.
6. **Bẫy nhân bản dòng khi nối nhiều bảng trước `SUM` / `COUNT`:**
   - Nếu nối `DATVE` (1 lượt) với `CTDV` ($k$ chi tiết) rồi tính `SUM(DATVE.SLVe)`, giá trị `SLVe` bị cộng lặp $k$ lần.
   - **Cách đúng:** Đếm/tổng đúng ở bảng có độ mịn phù hợp (`COUNT(CTDV.MaCTDV)` hoặc `SUM(DATVE.SLVe)` không nối xuống `CTDV`, hoặc `COUNT(DISTINCT ...)`).
7. **Bẫy phép chia SQL (ý `e` — 8/8 mã đề):**
   - **Cách 1 (`NOT EXISTS` 2 tầng):** Quên nối điều kiện liên hệ giữa tầng 3 với **cả tầng 1 lẫn tầng 2**, hoặc quên lặp điều kiện phụ (như *"đã thanh toán"*, *"trong lần đặt vé đó"*) vào đúng tầng.
   - **Cách 2 (`GROUP BY ... HAVING COUNT(...)`):** Quên lọc phần tử thuộc **đúng tập chia** trước khi đếm (ví dụ không lọc `LoaiBB = N'tạp chí quốc tế' AND MaDT = 'DT01'` ở truy vấn ngoài nên đếm nhầm cả bài ngoài tập chia!), hoặc quên `DISTINCT` khi 1 đối tượng có thể xuất hiện nhiều lần với cùng phần tử bị chia, hoặc quên trường hợp tập chia có thể rỗng.
8. **Bẫy `GROUP BY` thiếu cột trong MS SQL Server:**
   - Mọi cột không nằm trong hàm tổng hợp ở `SELECT` **bắt buộc phải xuất hiện trong `GROUP BY`**. Không dùng `GROUP BY` chỉ theo `Ten` vì có thể trùng tên — luôn gom theo `Ma` (khóa chính) kèm `Ten`.
9. **Bẫy cực trị toàn cục vs cực trị theo từng nhóm (ý `f`):**
   - Cực trị toàn cục (`CK20 C1.2f`): Dùng `TOP 1` **thiếu `WITH TIES`** sẽ làm rơi các đối tượng đồng hạng lớn nhất/nhỏ nhất. An toàn nhất: `HAVING COUNT(...) >= ALL (...)` hoặc `SELECT TOP 1 WITH TIES ... ORDER BY ... DESC`.
   - Cực trị **theo từng nhóm** (*"với mỗi phòng, tìm nhân viên ít đề tài nhất"*, `CK23 C1.2f`): `TOP 1 WITH TIES` **không áp dụng được cho toàn bảng** vì chỉ giữ đúng 1 mức thấp nhất toàn trường chứ không phải theo từng phòng. Phải so sánh tương quan `<= ALL` trong phạm vi cùng `MaPhong` (và chú ý dùng `LEFT JOIN` nếu tính cả nhân viên tham gia `0` đề tài).
10. **Bẫy mốc ngày/giờ và tiếng Việt trong MS SQL Server:**
    - So sánh chính xác cả ngày lẫn giờ (`10:30:00 ngày 20/12/2024` trong `CK24 C1.2b`): dùng định dạng ISO không nhập nhằng `'2024-12-20 10:30:00'` thay vì `'20/12/2024'` (phụ thuộc `DATEFORMAT`).
    - Dùng tiền tố `N'...'` cho chuỗi tiếng Việt có dấu (`N'Tân Sơn Nhất'`, `N'Đã thanh toán'`) theo chuẩn `NVARCHAR` của SQL Server.
    - Chú ý từ khóa **"bài báo khác"** (`CK23-Đề2 C1.2c`): phải có điều kiện `CB1.MaBB <> CB2.MaBB` khi tự kết (thực tế khóa chính `(MaNV, MaBB)` đã buộc 1 nhân viên chỉ có 1 vai trò trên 1 bài, nhưng viết rõ `<>` giúp chặt chẽ tuyệt đối).

---

## Phần 2 — Chương 5 (`T5 tr.1–53`): Ràng buộc toàn vẹn `[TRỌNG TÂM CK]`

Chiếm **1,5–2,0 / 10 điểm (15–20%)** ở cả 8/8 mã đề Cuối kỳ (`C1.1`).

### 2.1. Khái niệm và 3 đặc trưng bắt buộc (`T5 tr.3–16`)

RBTV là điều kiện bất biến mà mọi thể hiện của CSDL phải thỏa tại mọi thời điểm nhằm bảo đảm tính nhất quán và ngữ nghĩa thực tế (`T5 tr.3–4`). Một phát biểu chặt chẽ **bắt buộc có đủ 3 phần**:

1. **Bối cảnh (`T5 tr.10–11`):** Danh sách tất cả các quan hệ có khả năng làm vi phạm RBTV khi thực hiện thao tác cập nhật dữ liệu (Thêm, Xóa, Sửa).
2. **Nội dung (`T5 tr.7–9`):** Phát biểu hình thức chặt chẽ bằng logic vị từ (lượng từ $\forall, \exists$, phép kéo theo $\Rightarrow$, hội $\land$, phủ định $\neg$, hàm `COUNT`, tổng $\sum$).
3. **Bảng tầm ảnh hưởng (`T5 tr.12–16`):** Bảng 2 chiều xác định thời điểm cần kiểm tra RBTV:
   - Hàng: từng quan hệ trong **Bối cảnh**.
   - Cột: `Thêm`, `Xóa`, `Sửa`.
   - Ký hiệu trong ô:
     - **`+`**: Thao tác **có thể** làm vi phạm RBTV (cần kiểm tra). Với cột `Sửa`, **bắt buộc ghi rõ tên thuộc tính**: `+(ThuocTinh1, ThuocTinh2)`.
     - **`-`**: Thao tác **không làm** vi phạm RBTV.
     - **`-(*)`**: Không làm vi phạm vì **lý do đặc biệt** (bắt buộc ghi chú thích `(*)` ngay dưới bảng, ví dụ: *không được sửa khóa chính*, hoặc *thuộc tính tổng hợp mặc định = 0 khi thêm mới*).

**Quy định chuẩn khi phân tích (`T5 tr.14`):**
- Thao tác **Thêm** và **Xóa** xét trên **1 bộ** của quan hệ.
- Thao tác **Sửa** xét sửa **từng thuộc tính** trên 1 bộ của quan hệ.
- **Giả thiết tiền điều kiện:** Trước khi thao tác xảy ra, trạng thái CSDL **đang thỏa mãn RBTV**.

### 2.2. Phân loại RBTV theo `T5 tr.18–48`

| Nhóm | Loại RBTV | Trang T5 | Dạng nội dung tiêu biểu | Mức độ CK |
|---|---|---:|---|---|
| **1 quan hệ** | Miền giá trị | 19–21 | $\forall t \in R : t.A \le 60$ hoặc $t.A \in \{\dots\}$ | Nền tảng |
| **1 quan hệ** | Liên thuộc tính | 22–23 | $\forall t \in R : t.A < t.B$ hoặc $P(t.A) \Rightarrow Q(t.B)$ | Nền tảng |
| **1 quan hệ** | Liên bộ | 24–29 | Khóa chính, `UNIQUE`, số bộ tối đa trên 1 bảng: $\forall t \in R : \text{COUNT}_{(p\in R: p.K = t.K)}(*) \le 10$ | Nền tảng |
| **Nhiều quan hệ** | Tham chiếu (khóa ngoại) | 31–34 | $\forall d \in R, \exists p \in S : d.FK = p.PK$ (hoặc $R[FK] \subseteq S[PK]$) | Hay lồng trong bài |
| **Nhiều quan hệ** | **Liên bộ – liên quan hệ** `[TRỌNG TÂM CK]` | 35 | Có điều kiện lọc ở bảng cha + giới hạn `COUNT` ở bảng con (tối đa $\le k$ hoặc tối thiểu $\ge k$). **Xuất hiện ở `CK23`, `CK24-Đề2`** | **Rất cao** |
| **Nhiều quan hệ** | **Liên thuộc tính – liên quan hệ** `[TRỌNG TÂM CK]` | 36–37 | So sánh hoặc điều kiện cấm giữa thuộc tính các bảng khác nhau (kể cả nối qua bảng trung gian). **Xuất hiện ở `CK22`** | **Rất cao** |
| **Nhiều quan hệ** | **Thuộc tính tổng hợp** `[TRỌNG TÂM CK]` | 38–41 | Thuộc tính bảng cha `=` (hoặc `>=`) `COUNT` / `SUM` từ bảng con (có thể qua bảng trung gian). **Xuất hiện ở `CK24-Đề1`, `CK20`** | **Rất cao** |
| **Nhiều quan hệ** | Có sự hiện diện của chu trình | 42–48 | Hai đường đi giữa các quan hệ phải nhất quán ($A = B$ hoặc $A \subseteq B$, ví dụ `R20–R22`) | Dự phòng |

### 2.3. Bảy bẫy RBTV rất dễ mất điểm trong đề UIT `[TRỌNG TÂM CK]`

1. **Bẫy *"Lưu ý: Không được sửa thuộc tính khóa chính"*** (xuất hiện **8/8 mã đề**):
   - Trong slide `T5` gốc (tr.33, 35, 39, 40, 47), một số ví dụ chưa giả định cấm sửa khóa chính nên vẫn ghi `+(SoHD)` hay `+(MaDA)` cho khóa ghép.
   - **Trong đề thi có dòng lưu ý cấm sửa khóa chính:** Mọi thuộc tính thuộc **khóa chính** (kể cả 1 thành phần của khóa chính ghép như `MaNV`, `MaDT` trong `THAMGIADT` của `CK23`) **không thể bị sửa**.
   - Nếu bảng đó **không còn thuộc tính ngoài khóa nào ảnh hưởng RBTV** → cột `Sửa` ghi **`-(*)`** kèm chú thích `(*) Không được sửa thuộc tính khóa chính`.
   - Nếu bảng đó **còn thuộc tính ngoài khóa khác ảnh hưởng RBTV** → cột `Sửa` chỉ ghi `+(CộtNgoàiKhóa)` (và ghi thêm chú thích rằng thuộc tính khóa chính không sửa được).
2. **Bẫy thiếu bảng trung gian trong Bối cảnh:**
   - Khi hai bảng nối với nhau qua bảng thứ ba (`CANHO` — `TRAGOP` — `HINHTHUCTG` ở `CK22`; `BENHNHAN` — `KHAMBENH` — `PHAUTHUAT` ở `CK20`), **bảng trung gian bắt buộc phải có trong Bối cảnh** vì thêm/xóa/sửa khóa ngoại trên bảng trung gian trực tiếp làm thay đổi quan hệ giữa hai đầu.
3. **Bẫy đảo chiều `+` / `-` ở cột Thêm và Xóa theo dấu `=`, `>=`, `<=`:**

| Dạng điều kiện giữa Cha và Con | Cha: Thêm | Cha: Xóa | Con: Thêm | Con: Xóa |
|---|---|---|---|---|
| **Tối đa:** `Cha.Max >= COUNT/SUM(Con)` (`CK24`) hoặc `COUNT(Con) <= k` (`T5 tr.35`) | `+` *(nếu `Cha.Max` có thể `< 0`)* hoặc `-(*)` *(nếu tân từ đã buộc `Cha.Max >= 0`, mới thêm chưa có con nên `SUM/COUNT = 0`)* | `-` | **`+`** *(tăng vế phải)* | **`-`** *(giảm vế phải)* |
| **Tối thiểu:** `điều kiện(Cha) => COUNT(Con) >= k` (`CK23`, $k \ge 1$) | **`+`** *(mới thêm chưa có con $\to 0 < k$)* hoặc `-(*)` *(nếu mặc định không thỏa điều kiện lọc, VD `NghiemThu = 0`)* | `-` | **`-`** *(tăng số lượng)* | **`+`** *(giảm số lượng, có thể `< k`)* |
| **Bằng đúng:** `Cha.TongHop = COUNT/SUM(Con)` (`T5 tr.39–40`, `CK20`) | **`+`** *(kiểm tra `= 0`)* hoặc **`-(*)`** *(nếu mặc định `= 0`)* | `-` | **`+`** | **`+`** |
| **Cấm kết hợp:** `Cha1(P) ∧ Cha2(Q) => không có GiaoDich` (`CK22`) | `-` *(mới thêm chưa có giao dịch)* | `-` | **`+`** *(tạo cặp cấm)* | `-` |

4. **Bẫy bỏ sót giá trị mặc định ghi trong Tân từ đề bài:**
   - Đọc kỹ tân từ của từng bảng! Ví dụ:
     - `T5 tr.39–40`: Thêm `HOADON` là `+` nếu chưa có quy định mặc định `SLMH = 0`, là `-(*)` nếu đã có quy định mặc định `SLMH = 0`.
     - `CK23-Đề1`: Tân từ `DETAI` ghi rõ *"Khi thêm 1 đề tài mới trạng thái nghiệm thu mặc định là 0"* → Thêm `DETAI` là `-(*)` vì chưa nghiệm thu nên chưa kích hoạt điều kiện *"đã nghiệm thu"*.
     - `CK24-Đề1`: Tân từ `LICHBAY` ghi `SLVeKT > 0`; `CK24-Đề2`: `LOAIVE` ghi `SLVeToiDa >= 0` → mới thêm cha chưa có con (`SUM = 0` / `COUNT = 0`) nên luôn thỏa $\ge 0$ → ghi `-(*)` kèm giải thích rõ!
5. **Bẫy sót cột khóa ngoại (không phải khóa chính) ở cột Sửa:**
   - Nếu bảng con có khóa chính độc lập (như `CTDV(MaCTDV, ..., MaLV)` ở `CK24`, `BAIBAOKH(MaBB, ..., MaDT)` ở `CK23`, `TRAGOP(MATG, MACH, MAKH, MAHT, ...)` ở `CK22`, `PHAUTHUAT(MAPT, MAKB, ...)` ở `CK20`), thì khóa ngoại **KHÔNG thuộc khóa chính** nên **vẫn sửa được**!
   - Sửa khóa ngoại làm chuyển dòng từ cha cũ sang cha mới → luôn phải ghi vào cột `Sửa` (ví dụ `+(MaLV)`, `+(MaDT)`, `+(MACH, MAHT)`).
6. **Bẫy sót cột điều kiện lọc ở cột Sửa:**
   - Với ràng buộc dạng $P(\text{Cha}) \Rightarrow Q(\text{Con})$, sửa thuộc tính nằm trong $P$ có thể đưa một dòng từ trạng thái không áp dụng sang trạng thái phải áp dụng (nhưng chưa đủ con) → **phải ghi `+(thuộc tính trong P)`** (ví dụ `+(LoaiDT, NghiemThu)` ở `CK23-Đề1`, `+(LoaiDT, KinhPhi)` ở `CK23-Đề2`).
7. **Bẫy dùng sai phép nối logic `∧` thay cho kéo theo `⇒`:**
   - Viết $\forall d \in \text{DETAI} : d.\text{LoaiDT} \in \{\text{'A','B','C'}\} \land \dots$ sẽ có nghĩa sai là *"mọi đề tài trong bảng đều phải là đề tài cấp ĐHQG-HCM"*. Với điều kiện có tiền đề *"nếu / thuộc loại / có diện tích..."*, bắt buộc dùng **`⇒`** (hoặc dạng phủ định $\neg\exists$ cho ràng buộc cấm).

---

## Phần 3 — Chương 6 (`T6 tr.1–87`): Phụ thuộc hàm và Dạng chuẩn `[TRỌNG TÂM CK]`

Chiếm **2,0–2,5 / 10 điểm (20–25%)** ở cả 8/8 mã đề Cuối kỳ (`C2`).

### 3.1. Bất thường dữ liệu & Phụ thuộc hàm (`T6 tr.3–20`)

- **3 bất thường của thiết kế kém (`T6 tr.4–6`):** Bất thường **sửa** (dư thừa dẫn đến không nhất quán), bất thường **thêm** (không thêm được thông tin độc lập vì phần còn lại của khóa bị `NULL`), bất thường **xóa** (xóa 1 dòng làm mất theo thông tin của thực thể khác).
- **Định nghĩa PTH (`T6 tr.10`):** Trên lược đồ $R$, $X \to Y$ nếu và chỉ nếu với mọi cặp bộ $r_1, r_2$ của $R$:
  $$r_1[X] = r_2[X] \implies r_1[Y] = r_2[Y]$$
- **Hệ tiên đề Armstrong & 3 luật suy diễn (`T6 tr.13–14`):**
  1. **Phản xạ:** $Y \subseteq X \implies X \to Y$.
  2. **Tăng trưởng:** $X \to Y \implies XZ \to YZ$.
  3. **Bắc cầu:** $\{X \to Y,\; Y \to Z\} \implies X \to Z$.
  4. **Kết hợp:** $\{X \to Y,\; X \to Z\} \implies X \to YZ$.
  5. **Phân rã:** $X \to YZ \implies \{X \to Y,\; X \to Z\}$.
  6. **Tựa bắc cầu:** $\{X \to Y,\; YZ \to W\} \implies XZ \to W$.

### 3.2. Bao đóng & Bài toán thành viên (`T6 tr.21–35`) `[TRỌNG TÂM CK]`

- **Bao đóng tập PTH ($F^+$):** Tập tất cả các PTH được suy ra từ $F$ (`T6 tr.21`).
- **Bao đóng tập thuộc tính ($X^+_F$):** $X^+_F = \{A \in U \mid X \to A \in F^+\}$ (`T6 tr.24`).
- **Định lý giải bài toán thành viên (`T6 tr.24, 29`) — 8/8 mã đề hỏi ở C2.1:**
  $$X \to Y \in F^+ \iff Y \subseteq X^+_F$$
  *(Không cần dựng toàn bộ $F^+$ hay mò đường chứng minh Armstrong — chỉ cần tính $X^+_F$ từng bước rồi so sánh xem $Y$ có là tập con của $X^+_F$ hay không.)*

### 3.3. Khóa & Phân hoạch tập thuộc tính (`T6 tr.36–46`) `[TRỌNG TÂM CK]`

Cho lược đồ $R(U, F)$ (slide `T6` ký hiệu tập thuộc tính là $Q^+$ hoặc $U$):
- $K \subseteq U$ là **khóa** (khóa dự tuyển) của $R$ nếu thỏa đủ 2 điều kiện (`T6 tr.36`):
  1. $K^+_F = U$ ($K$ là siêu khóa).
  2. Không tồn tại tập con thực sự $K' \subset K$ sao cho $(K')^+_F = U$ (tính tối thiểu).
- **Thuộc tính khóa:** Thuộc tính $A$ thuộc **ít nhất một khóa** $K$ của $R$.
- **Thuộc tính không khóa:** Thuộc tính $A$ **không** thuộc bất kỳ khóa nào của $R$.
- **Siêu khóa:** Bất kỳ tập $S \subseteq U$ nào chứa ít nhất một khóa ($S \supseteq K$, tương đương $S^+_F = U$).
- **Phân hoạch $U$ thành 4 tập đôi một rời nhau để tìm khóa (`T6 tr.38–39`):**
  - **$T$ (Treo):** Không xuất hiện ở cả vế trái lẫn vế phải của mọi PTH trong $F$. *(Luôn thuộc mọi khóa.)*
  - **$N$ (Nguồn):** Chỉ xuất hiện ở vế trái của các PTH trong $F$. *(Luôn thuộc mọi khóa.)*
  - **$TG$ (Trung gian):** Xuất hiện ở cả vế trái lẫn vế phải của các PTH trong $F$. *(Có thể thuộc hoặc không thuộc khóa.)*
  - **$\text{Đ}$ (Đích):** Chỉ xuất hiện ở vế phải của các PTH trong $F$. *(Không bao giờ thuộc khóa tối thiểu.)*

### 3.4. Phân loại PTH & 4 Dạng chuẩn (`T6 tr.47–75`) `[TRỌNG TÂM CK]`

- **PTH riêng phần (`T6 tr.47`):** $X \to Z$ là riêng phần nếu tồn tại $Y \subset X$ sao cho $Y \to Z$.
- **PTH đầy đủ (`T6 tr.47`):** $X \to A$ là đầy đủ nếu không tồn tại $Y \subset X$ sao cho $Y \to A$.
- **PTH bắc cầu (`T6 tr.47`):** $X \to A$ là bắc cầu nếu tồn tại $Y$ sao cho $X \to Y$, $Y \to A$, $Y \not\to X$ và $A \notin XY$.

Quan hệ bao hàm dạng chuẩn: $\text{BCNF} \subset \text{3NF} \subset \text{2NF} \subset \text{1NF}$.

| Dạng chuẩn | Trang T6 | Định nghĩa & Tiêu chí kiểm tra thực hành chuẩn UIT | Nhận xét / Mẹo kiểm nhanh |
|---|---:|---|---|
| **1NF** | 51–53 | Mọi thuộc tính đều mang giá trị nguyên tố (không đa trị, không phức hợp) | Mọi lược đồ $R(U, F)$ ở Câu 2 mặc định đạt ít nhất **1NF** |
| **2NF** `[TRỌNG TÂM CK]` | 54–61 | Đạt 1NF và **mọi thuộc tính không khóa phụ thuộc đầy đủ vào mọi khóa**. Kiểm tra: với mỗi khóa $K$ và mọi tập con thực sự khác rỗng $S_i \subset K$, **$(S_i)^+_F$ không được chứa thuộc tính không khóa nào** | Nếu mọi khóa đều chỉ có **1 thuộc tính**, HOẶC **không có thuộc tính không khóa nào** $\implies$ chắc chắn đạt 2NF (`T6 tr.61`) |
| **3NF** `[TRỌNG TÂM CK]` | 62–70 | Đạt 2NF và không có thuộc tính không khóa phụ thuộc bắc cầu vào khóa. Kiểm tra trực tiếp trên $F$: tách vế phải thành từng thuộc tính đơn; với mọi $X \to A \in F$ ($A \notin X$), phải thỏa **(1) $X$ là siêu khóa** HOẶC **(2) $A$ là thuộc tính khóa** | Nếu mọi thuộc tính đều là thuộc tính khóa $\implies$ chắc chắn đạt **3NF** (`T6 tr.69`), nhưng vẫn phải kiểm BCNF! |
| **BCNF** `[TRỌNG TÂM CK]` | 71–74 | Với mọi $X \to A \in F$ ($A \notin X$), **$X$ bắt buộc là siêu khóa** (vế trái chứa ít nhất 1 khóa) | Điều kiện chặt nhất; chỉ cần 1 PTH không tầm thường có vế trái không là siêu khóa là loại ngay BCNF |

### 3.5. Tám bẫy Chương 6 rất dễ mất điểm trong đề UIT `[TRỌNG TÂM CK]`

1. **Bẫy quên tập thuộc tính Treo $T$:**
   - Nếu trong $U = \{A, B, C, D, E, G, H, I\}$ có 1 chữ cái không xuất hiện trong $F$, nó thuộc $T$, không phải bỏ quên. Bước 1 luôn phải xét **$(N \cup T)^+_F$** (`T6 tr.39, 43`).
2. **Bẫy phân loại nhầm $N, TG, \text{Đ}$:**
   - Một thuộc tính xuất hiện ở vế trái 3 lần nhưng vế phải chỉ 1 lần vẫn thuộc **$TG$**, không phải $N$. Luôn đối soát: $|T| + |N| + |TG| + |\text{Đ}| = |U|$.
3. **Bẫy dừng tính $X^+_F$ sau 1 lượt duyệt $F$:**
   - Khi thuộc tính mới xuất hiện ở $f_4$ hoặc $f_5$, phải quay lại kiểm tra $f_1, f_2, f_3$ vì vế trái của chúng có thể vừa được thỏa mãn. Lặp cho tới khi 1 lượt quét toàn bộ $F$ không thêm được chữ nào.
4. **Bẫy duyệt $CTG$ không tăng dần kích thước khi tìm khóa:**
   - Bắt buộc liệt kê tập con $X_i$ của $TG$ theo kích thước tăng dần (1 phần tử → 2 phần tử → 3 phần tử...). Ngay khi $N \cup T \cup X_i$ là khóa, loại bỏ toàn bộ $X_j \supset X_i$ còn lại trong $CTG$ để tránh nhận nhầm siêu khóa là khóa (`T6 tr.39–41, 80`).
5. **Bẫy tìm thiếu khóa dẫn đến sai hàng loạt Câu 2.3:**
   - Nếu $R$ có 2 khóa $K_1, K_2$ nhưng chỉ tìm được $K_1$, các thuộc tính thuộc $K_2 \setminus K_1$ sẽ bị xếp nhầm thành **thuộc tính không khóa**, kéo theo kết luận sai cả 2NF lẫn 3NF.
6. **Bẫy kiểm tra 2NF chỉ nhìn thẳng vào $F$ mà bỏ qua bao đóng $(S_i)^+_F$:**
   - Có trường hợp không có PTH trực tiếp $S_i \to A$ trong $F$, nhưng qua nhiều bước suy diễn vẫn có $A \in (S_i)^+_F$ (với $S_i \subset K$ và $A$ không khóa), ví dụ `T6 tr.83` ($K=BD$, $B \to A$, $AB \to C \implies B^+_F = BAC$ chứa $C$ không khóa $\implies$ **vi phạm 2NF**). Luôn kiểm bằng bao đóng $(S_i)^+_F$ của tập con thực sự của khóa!
7. **Bẫy không phân rã vế phải trước khi xét 3NF (`T6 tr.67`):**
   - Với $X \to BC$ (trong đó $X$ không là siêu khóa, $B$ là thuộc tính khóa, $C$ là thuộc tính không khóa): phải tách thành $X \to B$ (thỏa 3NF) và $X \to C$ (**vi phạm 3NF**). Nếu chỉ thấy $B$ là thuộc tính khóa mà bỏ qua $C$ sẽ kết luận sai!
8. **Bẫy nhầm câu hỏi *"có đạt 2NF không?"* với *"xác định dạng chuẩn cao nhất"*:**
   - Đề `CK23` và `CK20` chỉ hỏi *"có đạt 2NF không?"* (trả lời Có/Không và chứng minh theo 2NF).
   - Đề `CK24` và `CK22` hỏi *"xác định dạng chuẩn cao nhất"* → phải đi theo quy trình từ trên xuống **`BCNF → 3NF → 2NF → 1NF`** (`T6 tr.75`), chỉ rõ PTH vi phạm ở mỗi tầng bị loại cho tới tầng cao nhất đạt được.
