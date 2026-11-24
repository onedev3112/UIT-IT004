# Hệ thống Công thức & Quy trình giải bài tập chuẩn (Cuối kỳ CSDL)

Soạn ngày 24/11/2026 theo đúng chuẩn trình bày tự luận của slide `T4` (tr.41–95), `T5` (tr.1–53), `T6` (tr.1–87) và cấu trúc 8 mã đề `CK20–CK24`. Mọi công thức và khung mẫu dùng tên bảng/thuộc tính tổng quát để luyện quy trình từng bước không nhảy bước; **không chứa lời giải các đề thi gốc**.

---

## Phần 1 — Quy trình 4 bước giải Câu 1.1: Phát biểu chặt chẽ RBTV (`T5 tr.6–48`)

Mỗi câu RBTV (1,5–2,0 điểm) được chấm theo đủ **3 mục bắt buộc**: **Bối cảnh**, **Nội dung**, **Bảng tầm ảnh hưởng**. Làm đúng thứ tự 4 bước sau để không sót bảng và không sai dấu:

### Bước 1 — Khảo sát lược đồ & tân từ (nháp 1 phút)
1. Khoanh tròn **khóa chính** của từng bảng liên quan (phân biệt rõ khóa đơn vs khóa ghép).
2. Ghi lại mọi **ràng buộc nền / giá trị mặc định** đã nêu trong tân từ (ví dụ: *"SLVeKT > 0"*, *"SLVeToiDa >= 0"*, *"khi thêm đề tài mới, NghiemThu mặc định là 0"*).
3. Vẽ nhanh đường nối khóa ngoại giữa các bảng tham gia câu phát biểu; đánh dấu rõ bảng trung gian nếu hai bảng không nối trực tiếp.

### Bước 2 — Chốt **Bối cảnh**
- Bối cảnh gồm **tất cả các quan hệ** có chứa:
  1. Thuộc tính điều kiện lọc (vế trái $\Rightarrow$).
  2. Thuộc tính so sánh / tổng hợp / bị đếm.
  3. Bảng trung gian nối khóa ngoại giữa hai đầu.
- Kiểm tra lại: nếu thiếu bảng trung gian nối $A$ với $C$, công thức Nội dung sẽ không nối được $A$ sang $C$.

### Bước 3 — Viết **Nội dung** bằng ngôn ngữ hình thức chuẩn `T5`

Chọn đúng khuôn trong 4 khuôn xuất hiện trong đề Cuối kỳ:

#### Khuôn RBTV-1: Thuộc tính tổng hợp hoặc giới hạn tổng/đếm (`=`, `>=`, `<=`) — `T5 tr.39–40`
- **Trường hợp 2 bảng trực tiếp** (Cha $A$, Con $B$ nối qua $b.K_A = a.K_A$):
  $$\forall a \in A,\; a.\text{ThuocTinhTH} \;\odot\; \text{COUNT}_{(b \in B : b.K_A = a.K_A)}(*)$$
  $$\forall a \in A,\; a.\text{ThuocTinhTH} \;\odot\; \sum_{(b \in B : b.K_A = a.K_A)}(b.\text{GiaTri})$$
  *(với $\odot \in \{=, \ge, \le\}$ tùy theo đề: "bằng", "lớn hơn hoặc bằng", "nhỏ hơn hoặc bằng").*
- **Trường hợp 3 bảng qua bảng trung gian** (Cha $A$, Trung gian $B$ nối $A$, Cháu $C$ nối $B$):
  $$\forall a \in A,\; a.\text{ThuocTinhTH} = \text{COUNT}_{(c \in C : \exists b \in B,\, b.K_A = a.K_A \land c.K_B = b.K_B)}(*)$$

#### Khuôn RBTV-2: Liên bộ – liên quan hệ có điều kiện lọc + tối thiểu/tối đa $k$ — `T5 tr.35`
$$\forall a \in A : P(a) \implies \text{COUNT}_{(b \in B : b.K_A = a.K_A)}(b.\text{MaB}) \ge k \quad (\text{hoặc } \le k)$$
- $P(a)$ là điều kiện lọc trên bảng cha $A$ (ví dụ loại thuộc tập cho trước, đã nghiệm thu, kinh phí vượt ngưỡng).
- Bắt buộc dùng **$\implies$** (không dùng $\land$).

#### Khuôn RBTV-3: Liên thuộc tính – liên quan hệ dạng cấm (2 hoặc 3 bảng) — `T5 tr.36–37`
- **Cách viết thuận (kéo theo — khuyên dùng):**
  $$\forall g \in GD,\; \forall a \in A,\; \forall b \in B : (g.K_A = a.K_A \land g.K_B = b.K_B \land P(a)) \implies \neg Q(b)$$
- **Cách viết phủ định tương đương:**
  $$\neg \exists g \in GD,\; \exists a \in A,\; \exists b \in B : g.K_A = a.K_A \land g.K_B = b.K_B \land P(a) \land Q(b)$$
  *(Lưu ý đảo đúng dấu bất đẳng thức trong $\neg Q(b)$: phủ định của `< 24` là `>= 24`; phủ định của `> 36` là `<= 36`.)*

#### Khuôn RBTV-4: Chu trình nhất quán ($A \subseteq B$) — `T5 tr.47–48`
$$\forall g \in GD,\; \exists a \in A,\; \exists b \in B : g.K_A = a.K_A \land g.K_B = b.K_B \land a.\text{ThuocTinhChung} = b.\text{ThuocTinhChung}$$

### Bước 4 — Lập **Bảng tầm ảnh hưởng** từng ô (không đoán cảm tính)

Giả thiết chuẩn (`T5 tr.14`): **trước thao tác, CSDL đang thỏa RBTV**; Thêm/Xóa xét 1 bộ; Sửa xét từng thuộc tính; và áp dụng lưu ý đề bài **"Không được sửa thuộc tính khóa chính"**.

Với **từng quan hệ $Q$ trong Bối cảnh**, lần lượt điền 3 cột theo 3 câu hỏi sau:

1. **Cột `Thêm`:** Nếu chèn 1 bộ mới $q$ vào $Q$, ràng buộc có thể bị phá vỡ không?
   - **Bảng cha có `COUNT >= k` ($k \ge 1$):** Bộ cha mới chưa có con nào (`COUNT = 0 < k`) $\to$ **`+`**; riêng nếu tân từ có giá trị mặc định làm $P(q)$ **sai** ngay lúc tạo (ví dụ `NghiemThu` mặc định `= 0`) $\to$ **`-(*)`** và ghi chú thích.
   - **Bảng cha có thuộc tính tổng hợp `=` hoặc `>=`:**
     - Dạng `=`: ghi **`+`** (kiểm tra bằng `0` khi tạo mới) hoặc **`-(*)`** nếu tân từ quy định mặc định `= 0` (`T5 tr.39–40`).
     - Dạng `Cha.Max >= SUM/COUNT(Con)`: nếu tân từ đã buộc `Cha.Max > 0` hoặc `>= 0`, khi mới thêm chưa có con (`SUM/COUNT = 0`) nên luôn thỏa $\to$ **`-(*)`** (nếu không có ràng buộc nền $\to$ **`+`**).
   - **Bảng con / bảng giao dịch:**
     - Ràng buộc `<= k`, `Cha.Max >= Con`, `=`, hoặc dạng **cấm**: Thêm bộ con có thể làm vượt ngưỡng / lệch tổng / tạo cặp cấm $\to$ **`+`**.
     - Ràng buộc `>= k`: Thêm bộ con chỉ làm tăng số lượng ($\ge k$ sẵn rồi nên vẫn $\ge k$) $\to$ **`-`**.
2. **Cột `Xóa`:** Nếu xóa 1 bộ $q$ khỏi $Q$, ràng buộc có thể bị phá vỡ không?
   - **Bảng cha:** Xóa bộ cha làm bộ đó không còn nằm trong phạm vi lượng từ $\forall a \in A$ (các ràng buộc khóa ngoại nếu có do RBTV tham chiếu quản lý riêng) $\to$ **`-`**.
   - **Bảng con:**
     - Ràng buộc `>= k` hoặc `=`: Xóa bộ con làm giảm số lượng/tổng $\to$ **`+`**.
     - Ràng buộc `<= k`, `Cha.Max >= Con`, hoặc dạng **cấm**: Xóa bộ con chỉ làm giảm vế phải hoặc bớt cặp giao dịch $\to$ **`-`**.
   - **Bảng trung gian** (ví dụ $B$ nằm giữa $A$ và $C$ trong ràng buộc `=`): Xóa $b \in B$ (nếu không bị khóa ngoại chặn) hoặc xét theo ràng buộc tổng hợp $\to$ nếu còn con $c$ tham chiếu $b$ sẽ bị RBTV tham chiếu chặn, còn trong bảng tầm ảnh hưởng cần ghi rõ `-` (hoặc `-(*)` vì RBTV tham chiếu) nếu xóa $b$ chỉ hợp lệ khi không có $c$ nào thuộc $b$.
3. **Cột `Sửa`:**
   - **Bước 4.3a:** Liệt kê tất cả thuộc tính của $Q$ xuất hiện trong công thức **Nội dung** (thuộc tính điều kiện lọc $P$, thuộc tính so sánh/tính tổng, và thuộc tính khóa nối).
   - **Bước 4.3b:** Kiểm tra từng thuộc tính trong danh sách đó:
     - Thuộc tính **thuộc khóa chính** của $Q$ $\to$ loại khỏi `+(...)` vì đề cấm sửa khóa chính.
     - Thuộc tính **không thuộc khóa chính** $\to$ xét xem sửa tăng hoặc sửa giảm giá trị của nó có thể làm sai công thức không. Nếu có $\to$ giữ lại trong `+(...)`. *(Mọi khóa ngoại không nằm trong khóa chính hầu như luôn làm chuyển dòng sang cha khác nên giữ trong `+(...)`.)*
   - **Bước 4.3c:** Ghi kết quả ô `Sửa`:
     - Có ít nhất 1 thuộc tính ngoài khóa ảnh hưởng $\to$ **`+(Cot1, Cot2)`** (kèm chú thích các khóa chính không được sửa nếu cần).
     - Không còn thuộc tính ngoài khóa nào, chỉ có khóa chính liên quan $\to$ **`-(*)`** kèm dòng chú thích `(*) Không được sửa thuộc tính khóa chính`.
     - Hoàn toàn không thuộc tính nào ảnh hưởng $\to$ **`-`**.

---

## Phần 2 — Quy trình & Khuôn giải chuẩn Câu 1.2a–f: Truy vấn SQL (`T4 tr.41–95`)

### 2.1. Quy trình 5 bước viết một câu SQL sạch điểm

1. **Chốt đầu ra:** Ghi ra đúng các cột đề yêu cầu hiển thị (`Ma`, `Ten`, `SL`...), thứ tự `ORDER BY`, và kiểm xem có cần `DISTINCT` không (khi nối 1–nhiều mà chỉ xuất cột bên 1).
2. **Xác định đường nối & loại `JOIN`:** Vẽ chuỗi bảng từ đầu vào đến đầu ra theo khóa ngoại. Mặc định dùng `INNER JOIN`; chuyển sang `LEFT OUTER JOIN` khi đề hỏi *"với mỗi..."* cần giữ cả đối tượng có số lượng `0` (hoặc hỏi *"nếu có"*).
3. **Tách 3 tầng điều kiện:**
   - Điều kiện trên **từng dòng** $\to$ `WHERE` (hoặc `ON` nếu là bảng phải của `LEFT JOIN`).
   - Điều kiện **tập hợp / phủ tập** (*"cả hai"*, *"không có"*, *"tất cả"*) $\to$ `INTERSECT` / `EXCEPT` / `EXISTS` / `NOT EXISTS`.
   - Điều kiện trên **kết quả nhóm** (`COUNT`, `SUM`, cực trị) $\to$ `HAVING`.
4. **Chọn khuôn mẫu tương ứng** (bảng mục 2.2) và đặt bí danh bảng ngắn, rõ (`KH`, `DV`, `CT`, `LB`...).
5. **Soát nhanh 5 lỗi cuối bài:**
   - Mọi cột không nằm trong hàm tổng hợp ở `SELECT` đã có mặt trong `GROUP BY` chưa?
   - Tên cột trùng nhau giữa hai bảng đã gắn bí danh bảng (`A.MaX`) chưa?
   - Có đặt `COUNT`/`SUM` nhầm vào `WHERE` không?
   - Với `LEFT JOIN`: điều kiện bảng phải có lỡ đặt ở `WHERE` và có dùng nhầm `COUNT(*)` không?
   - Chuỗi tiếng Việt có tiền tố `N'...'` và ngày/giờ đúng chuẩn ISO chưa?

### 2.2. Bảng từ khóa → Khuôn SQL chuẩn MS SQL Server `[TRỌNG TÂM CK]`

| Từ khóa / Dạng câu trong đề | Khuôn SQL chuẩn MS SQL Server | Trang T4 |
|---|---|---:|
| *"Liệt kê ... sắp xếp tăng/giảm dần"* | `SELECT [DISTINCT] ... FROM A JOIN B ON ... WHERE ... ORDER BY cot [ASC \| DESC]` | 48–62 |
| *"Đồng thời cả A và B"* / *"vừa ... vừa ..."* | **Cách 1:** `(SELECT K FROM ... WHERE A) INTERSECT (SELECT K FROM ... WHERE B)`<br>**Cách 2:** `SELECT ... FROM U WHERE EXISTS (A) AND EXISTS (B)` | 65, 70–72 |
| *"Có A nhưng không B"* / *"chưa từng ..."* | **Cách 1:** `(SELECT K FROM ... WHERE A) EXCEPT (SELECT K FROM ... WHERE B)`<br>**Cách 2:** `SELECT ... FROM U WHERE <đk A> AND NOT EXISTS (SELECT 1 FROM ... WHERE nối AND <đk B>)` | 66–67, 73–76, 95 |
| *"Thống kê số lượng / tổng ... theo từng ..."* | `SELECT A.Ma, A.Ten, COUNT(B.MaB) AS SL FROM A LEFT JOIN B ON A.Ma = B.Ma AND <đk bảng B> GROUP BY A.Ma, A.Ten` *(dùng `INNER JOIN` nếu đề chỉ xét đối tượng đã có phát sinh)* | 82–87, 93–95 |
| *"Có số lượng / tổng lớn hơn k"* | `... GROUP BY A.Ma, A.Ten HAVING COUNT(...) > k` *(hoặc `SUM(...) > k`)* | 87 |
| *"Tất cả ..."* (**Phép chia — 8/8 đề**) | **Khuôn E1 (`NOT EXISTS` 2 tầng)** hoặc **Khuôn E2 (`GROUP BY ... HAVING COUNT(DISTINCT ...)`)** — xem chi tiết mục 2.3 | 79–81, 92 |
| *"Nhiều nhất / ít nhất"* (toàn cục) | **Cách 1:** `... GROUP BY ... HAVING COUNT(...) >= ALL (SELECT COUNT(...) FROM ... GROUP BY ...)`<br>**Cách 2:** `SELECT TOP 1 WITH TIES ... GROUP BY ... ORDER BY COUNT(...) DESC` | 88–90 |
| *"Với mỗi nhóm G, tìm đối tượng ít/nhiều nhất"* | Dùng **CTE / bảng tạm thống kê** theo `(MaG, MaX)` rồi lọc `SL <= ALL (SELECT SL FROM ThongKe T2 WHERE T2.MaG = T1.MaG)` — xem mục 2.4 | 82–95 |

### 2.3. Hai khuôn chuẩn cho **Phép chia trong SQL** (`C1.2e` — 8/8 mã đề) `[TRỌNG TÂM CK]`

Đặt bài toán chuẩn: **Tìm đối tượng $x \in U$ (thỏa điều kiện ứng viên $P_U(x)$) có quan hệ trong bảng $R$ (thỏa điều kiện giao dịch $P_R$) với TẤT CẢ phần tử $y \in S$ (thỏa điều kiện tập chia $P_S(y)$).**

#### Khuôn E1 — `NOT EXISTS` 2 tầng (`T4 tr.80`, khuyến nghị ưu tiên)
Đọc thành câu tiếng Việt để không bao giờ viết nhầm: *"Chọn $x \in U$ thỏa $P_U(x)$ sao cho **không tồn tại** phần tử $y \in S$ nào thỏa $P_S(y)$ mà lại **không tồn tại** dòng $r \in R$ nối $x$ với $y$ và thỏa $P_R$."*

```sql
SELECT U.MaX, U.TenX
FROM TapUngVien U
WHERE <P_U(U)>
  AND NOT EXISTS (
      SELECT 1
      FROM TapChia S
      WHERE <P_S(S)>
        AND NOT EXISTS (
            SELECT 1
            FROM QuanHeNoi R
            WHERE R.MaX = U.MaX
              AND R.MaY = S.MaY
              AND <P_R(R)>
        )
  );
```

- **Lưu ý 1 (rất hay gặp ở `CK24-Đề1 C1.2e`):** Nếu đề hỏi *"thành viên đã thanh toán đặt vé và đặt tất cả các loại vé của lịch bay L **trong lần đặt vé đó**"* → đối tượng phủ tập là **lượt đặt vé** (`DATVE`) chứ không phải cộng dồn nhiều lượt đặt vé khác nhau của thành viên! Khi đó tầng ngoài duyệt `THANHVIEN` nối `DATVE` (lọc `TTDatVe = N'Đã thanh toán'` và `MaLB = ...`), còn tầng 3 kiểm tra `CTDV` theo đúng `CTDV.MaDV = DV.MaDV AND CTDV.MaLV = LV.MaLV`!
- **Lưu ý 2 (trường hợp biên tập chia rỗng):** Nếu muốn loại trừ trường hợp tập chia $S$ rỗng (vì `NOT EXISTS` trên tập rỗng trả `TRUE`), có thể thêm `AND EXISTS (SELECT 1 FROM TapChia S WHERE <P_S(S)>)`.

#### Khuôn E2 — `GROUP BY ... HAVING COUNT(DISTINCT ...)` (`T4 tr.92`)

```sql
SELECT U.MaX, U.TenX
FROM TapUngVien U
JOIN QuanHeNoi R ON U.MaX = R.MaX
JOIN TapChia S   ON R.MaY = S.MaY
WHERE <P_U(U)>
  AND <P_R(R)>
  AND <P_S(S)>          -- BẮT BUỘC: chỉ đếm các Y thuộc đúng tập chia S!
GROUP BY U.MaX, U.TenX
HAVING COUNT(DISTINCT S.MaY) = (
    SELECT COUNT(DISTINCT MaY)
    FROM TapChia
    WHERE <P_S>
);
```

- **Ưu điểm:** Ngắn gọn, dễ đọc.
- **Bắt buộc nhớ 2 chốt chặn:** (1) Phải lọc `<P_S(S)>` ở truy vấn ngoài (nếu quên sẽ đếm cả các $Y$ ngoài tập chia); (2) Luôn dùng `COUNT(DISTINCT S.MaY)` để tránh 1 đối tượng gắn nhiều lần với cùng 1 $Y$ làm nhảy số đếm.

### 2.4. Khuôn chuẩn cho **Cực trị theo từng nhóm** (`CK23 C1.2f`) và **Đối chiếu tổng hợp** (`CK24 C1.2f`)

#### Khuôn F2 — Cực trị theo từng nhóm (*"với mỗi phòng, tìm nhân viên tham gia ít đề tài nhất"*)
Dùng `LEFT JOIN` để không bỏ sót nhân viên có `0` đề tài (nếu đề không giới hạn *"đã tham gia ít nhất 1"*):

```sql
WITH ThongKe AS (
    SELECT NV.MaPhong, NV.MaNV, NV.HoTen, COUNT(TG.MaDT) AS SoLuong
    FROM NHANVIEN NV
    LEFT JOIN THAMGIADT TG ON NV.MaNV = TG.MaNV
    GROUP BY NV.MaPhong, NV.MaNV, NV.HoTen
)
SELECT TK1.MaPhong, TK1.MaNV, TK1.HoTen, TK1.SoLuong
FROM ThongKe TK1
WHERE TK1.SoLuong <= ALL (
    SELECT TK2.SoLuong
    FROM ThongKe TK2
    WHERE TK2.MaPhong = TK1.MaPhong
);
```

*(Nếu làm bài giấy không muốn dùng `WITH`, có thể viết truy vấn con lặp lại tương ứng ở `HAVING COUNT(TG.MaDT) <= ALL (SELECT COUNT(TG2.MaDT) FROM NHANVIEN NV2 LEFT JOIN THAMGIADT TG2 ON NV2.MaNV = TG2.MaNV WHERE NV2.MaPhong = NV.MaPhong GROUP BY NV2.MaNV)` — cả hai đều chuẩn MS SQL Server và giữ trọn các nhân viên đồng hạng trong từng phòng!)*

#### Khuôn F3 — Đối chiếu tổng hợp (*"lịch bay / loại vé đã đặt hết"*)

```sql
SELECT A.MaA, A.ThongTinKhac
FROM BangCha A
JOIN BangCon B ON A.MaA = B.MaA
WHERE <điều kiện lọc A và B hợp lệ>
GROUP BY A.MaA, A.ThongTinKhac, A.SoLuongToiDa
HAVING COUNT(B.MaB) >= A.SoLuongToiDa; -- hoặc SUM(B.SL) = A.SoLuongToiDa
```

*(Kiểm tra kỹ tân từ xem lượt đặt vé có trạng thái `"Hủy"` hay không để cân nhắc điều kiện lọc và ghi rõ giả thiết nếu đề không nói rõ tính trạng thái nào.)*

---

## Phần 3 — Quy trình không nhảy bước giải Câu 2: PTH, Khóa & Dạng chuẩn (`T6 tr.13–86`)

### 3.1. Thuật toán 1 — Kiểm tra PTH thành viên $X \to Y \in F^+$ (`C2.1`, `T6 tr.26–30`)

**Cơ sở lý thuyết:** $X \to Y \in F^+ \iff Y \subseteq X^+_F$.

**Mẫu trình bày không mất điểm giải thích:**
1. Khởi tạo: $X^+_F = X$.
2. Lặp quét toàn bộ các PTH $Z \to V \in F$: nếu $Z \subseteq X^+_F$ và $V \not\subseteq X^+_F$ thì cập nhật $X^+_F = X^+_F \cup V$, ghi rõ lý do `(vì f_i: Z → V)`.
3. Dừng khi quét trọn một vòng tất cả các PTH trong $F$ mà $X^+_F$ không tăng thêm thuộc tính nào.
4. So sánh $Y$ với $X^+_F$:
   - Nếu $Y \subseteq X^+_F \implies$ Kết luận: **$X \to Y$ là phụ thuộc hàm thành viên của $F^+$**.
   - Nếu $Y \not\subseteq X^+_F$ (chỉ rõ cụ thể thuộc tính $A \in Y$ mà $A \notin X^+_F$) $\implies$ Kết luận: **$X \to Y$ không là phụ thuộc hàm thành viên của $F^+$**.

### 3.2. Thuật toán 2 — Tìm tất cả các khóa của $R(U, F)$ (`C2.2`, `T6 tr.38–46`)

**Bước 1 — Phân hoạch $U$ thành 4 tập & kiểm tra $(N \cup T)^+_F$:**
- Liệt kê $V_T$ (mọi thuộc tính xuất hiện ở vế trái của $F$) và $V_P$ (mọi thuộc tính xuất hiện ở vế phải của $F$).
- Suy ra 4 tập đôi một rời nhau:
  - $T = U \setminus (V_T \cup V_P)$ *(thuộc tính treo — không xuất hiện trong $F$)*.
  - $N = V_T \setminus V_P$ *(thuộc tính nguồn — chỉ ở vế trái)*.
  - $TG = V_T \cap V_P$ *(thuộc tính trung gian — ở cả hai vế)*.
  - $\text{Đ} = V_P \setminus V_T$ *(thuộc tính đích — chỉ ở vế phải)*.
- **Kiểm soát bắt buộc:** $|T| + |N| + |TG| + |\text{Đ}| = |U|$.
- Tính $(N \cup T)^+_F$:
  - Nếu $(N \cup T)^+_F = U \implies$ **Dừng ngay**, $R$ có **duy nhất 1 khóa** là $K = N \cup T$.
  - Nếu $(N \cup T)^+_F \neq U \implies$ sang Bước 2.

**Bước 2 — Lập tập các tập con khác rỗng $CTG$ của $TG$ theo kích thước tăng dần:**
- Nếu $|TG| = k$, có $2^k - 1$ tập con khác rỗng. Luôn liệt kê theo thứ tự: **tập 1 phần tử $\to$ tập 2 phần tử $\to$ tập 3 phần tử $\to \dots$**.

**Bước 3 — Kẻ bảng duyệt $(N \cup T \cup X_i)^+_F$ và loại siêu khóa dư:**

| $N \cup T$ | $X_i \in CTG$ | $N \cup T \cup X_i$ | $(N \cup T \cup X_i)^+_F$ và Kết luận |
|---|---|---|---|
| $\dots$ | *(tập 1 ptử)* | $\dots$ | Nếu $= U$: **Là khóa**. **Loại mọi $X_j \in CTG$ chứa $X_i$**. |
| $\dots$ | *(tập kế tiếp chưa bị loại)* | $\dots$ | Nếu $\neq U$: Không phải khóa (giữ các tập lớn hơn). |

*(Mẹo trình bày khi $N \cup T = \emptyset$: cột 1 ghi $\emptyset$, cột 3 chính là $X_i$, như `T6 tr.45, 80`.)*

**Bước 4 — Chốt kết quả khóa & phân loại thuộc tính (phục vụ ngay cho C2.3):**
- Tập tất cả các khóa của $R$: $S = \{K_1, K_2, \dots\}$.
- **Tập thuộc tính khóa:** $\text{TTK} = K_1 \cup K_2 \cup \dots$
- **Tập thuộc tính không khóa:** $\text{TTKK} = U \setminus \text{TTK}$.

### 3.3. Thuật toán 3 — Kiểm tra 2NF & Xác định Dạng chuẩn cao nhất (`C2.3`, `T6 tr.54–86`)

#### Bước chuẩn bị (bắt buộc trước khi xét)
- Tách mọi PTH có nhiều thuộc tính ở vế phải thành từng PTH đơn $X \to A$ (bỏ PTH tầm thường $A \in X$).
- Ghi rõ danh sách **Tất cả các khóa $S$**, **Thuộc tính khóa ($\text{TTK}$)**, **Thuộc tính không khóa ($\text{TTKK}$)**.

#### Nhánh A — Đề hỏi: *"Lược đồ có đạt dạng chuẩn 2 (2NF) không?"* (`CK23`, `CK20`)
1. **Kiểm tra nhanh 2 điều kiện đủ (`T6 tr.61`):**
   - Nếu mọi khóa $K \in S$ chỉ có 1 thuộc tính (`|K| = 1`), HOẶC $\text{TTKK} = \emptyset$ $\implies$ kết luận ngay **$R$ đạt 2NF**.
2. **Trường hợp có khóa ghép (`|K| >= 2`) và $\text{TTKK} \neq \emptyset$ (`T6 tr.55`):**
   - Với từng khóa $K \in S$, liệt kê tất cả tập con thực sự khác rỗng $S_i \subset K$ và tính $(S_i)^+_F$.
   - **Nếu tồn tại** một khóa $K$, một tập con thực sự $S_i \subset K$ và một thuộc tính $A \in \text{TTKK}$ sao cho $A \in (S_i)^+_F$:
     - Kết luận: **$R$ không đạt 2NF** vì thuộc tính không khóa $A$ phụ thuộc riêng phần vào khóa $K$ (do $S_i \subset K$ mà $S_i \to A$, hay $A \in (S_i)^+_F$).
   - **Nếu không tồn tại** cặp $(S_i, A)$ nào vi phạm trên mọi khóa $K \in S$:
     - Kết luận: **$R$ đạt 2NF** (mọi thuộc tính không khóa đều phụ thuộc đầy đủ vào mọi khóa).

#### Nhánh B — Đề hỏi: *"Xác định dạng chuẩn cao nhất của lược đồ"* (`CK24`, `CK22`)

Đi đúng thứ tự **từ cao xuống thấp** (`T6 tr.75`):

```text
Bước 1: Kiểm BCNF (mọi X → A không tầm thường có X là siêu khóa?)
   ├── ĐÚNG → Dạng chuẩn cao nhất là BCNF (DỪNG).
   └── SAI  → Chỉ rõ 1 PTH X → A có X không chứa khóa nào → Không đạt BCNF → Bước 2.

Bước 2: Kiểm 3NF (mọi X → A không tầm thường có [X là siêu khóa] HOẶC [A ∈ TTK]?)
   ├── ĐÚNG → Dạng chuẩn cao nhất là 3NF (DỪNG).
   └── SAI  → Chỉ rõ 1 PTH X → A có X không là siêu khóa VÀ A ∈ TTKK → Không đạt 3NF → Bước 3.

Bước 3: Kiểm 2NF (mọi tập con thực sự S_i ⊂ K của mọi khóa K có (S_i)+_F ∩ TTKK = ∅?)
   ├── ĐÚNG → Dạng chuẩn cao nhất là 2NF (DỪNG).
   └── SAI  → Chỉ rõ S_i ⊂ K và A ∈ (S_i)+_F ∩ TTKK → Không đạt 2NF → Dạng chuẩn cao nhất là 1NF.
```

**Checklist soát điểm Câu 2 trước khi nộp:**
- [ ] Ở Bước kiểm 3NF đã **phân rã vế phải** của mọi PTH chưa?
- [ ] Ở Bước kiểm 2NF đã kiểm **bao đóng $(S_i)^+_F$** chứ không chỉ nhìn trực tiếp các PTH gốc trong $F$ chưa?
- [ ] Mỗi kết luận *"không đạt BCNF / 3NF / 2NF"* đã chỉ ra **đích danh PTH hoặc tập con $S_i \subset K$ vi phạm** chưa?
