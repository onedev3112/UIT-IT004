# Phạm vi và thứ tự ôn Cuối kỳ Cơ sở dữ liệu

Chuẩn bị ngày 24/11/2026 trên cơ sở bộ tài liệu lý thuyết và đề thi Cuối kỳ người dùng mới bổ sung. Người học đã hoàn thành giai đoạn ôn Giữa kỳ (Chương 1, Chương 2, Chương 3 và Chương 4 phần DDL/DML trang 1–40), nên lộ trình này **chỉ khoanh vùng phần kiến thức chưa thi Giữa kỳ và ma trận đề Cuối kỳ**, tránh lặp lại nội dung cũ.

## 1. Nguồn được dùng

Kiến thức Cuối kỳ lấy chính từ phần nửa sau của `T4` và hai PDF lý thuyết mới `T5`, `T6`; đề luyện, thống kê và xếp trọng tâm chỉ lấy từ bốn PDF trong thư mục `Cuối kỳ/`. Chỉ dùng phần câu hỏi từ đề gốc; không lấy đề mạng hoặc đáp án ngoài làm căn cứ. Bản trích xuất trong `tmp/study_audit/` là bản đọc lại của chính các PDF này.

| Mã | PDF nguồn | Số trang PDF | Phạm vi dùng cho Cuối kỳ |
|---|---|---:|---|
| T4 | [Chương 4 — SQL](<../Lý thuyết/DPL_Chuong 4 - SQL.pdf>) | 98 | **Trang PDF 41–95** (Ngôn ngữ truy vấn dữ liệu; tr.96–98 tổng kết) |
| T5 | [Chương 5 — Ràng buộc toàn vẹn](<../Lý thuyết/DPL_Chuong 5 - Rang buoc toan ven.pdf>) | 53 | **Toàn chương (tr.1–53)** |
| T6 | [Chương 6 — Phụ thuộc hàm và Dạng chuẩn](<../Lý thuyết/DPL_Chuong 6 - Dang chuan.pdf>) | 87 | **Toàn chương (tr.1–87)** |
| CK24 | [Đề cuối kỳ HK1 2024–2025](<../Cuối kỳ/[BHTCNPM] CSDL 2024_2025 CK1.pdf>) | 4 | Đề 1 (tr.1–2), Đề 2 (tr.3–4) — **ưu tiên số 1** |
| CK23 | [Đề cuối kỳ HK1 2023–2024](<../Cuối kỳ/[BHTCNPM] CSDL 2023_2024 CK1.pdf>) | 4 | Đề 1 (tr.1–2), Đề 2 (tr.3–4) — **ưu tiên số 2** |
| CK22 | [Đề cuối kỳ HK1 2022–2023](<../Cuối kỳ/[BHTCNPM] CSDL 2022-2023 CK1.pdf>) | 4 | Đề 1 (tr.1–2), Đề 2 (tr.3–4) — **ưu tiên số 3** |
| CK20 | [Đề cuối kỳ HK1 2020–2021](<../Cuối kỳ/[BHTCNPM] CSDL 2020-2021 CK1.pdf>) | 6 | Đề 1 (tr.1–3), Đề 2 (tr.4–6) — **ưu tiên số 4** |

Tổng nguồn lý thuyết mới vào phạm vi Cuối kỳ: **195 trang** (55 trang DQL trong `T4` + 53 trang `T5` + 87 trang `T6`); nguồn đề Cuối kỳ: **18 trang / 8 mã đề**. Mọi số trang trong toàn bộ tài liệu ôn là **trang vật lý PDF, đếm từ 1**.

Quy ước mã câu: ví dụ `CK24-Đề1 C1.2e` nghĩa là ý `e` phần truy vấn SQL (`1.2`) thuộc Câu 1 của Đề 1 năm 2024–2025; `CK24-Đề1 C2.3` nghĩa là ý 3 của Câu 2 (xác định dạng chuẩn cao nhất).

## 2. Khoanh vùng chính xác phạm vi Cuối kỳ (tránh lặp Giữa kỳ)

### Nội dung không lặp lại trong lộ trình Cuối kỳ
- **Chương 1 (T1):** Tổng quan CSDL và vẽ mô hình ER.
- **Chương 2 (T2):** Mô hình dữ liệu quan hệ và chuyển ER → lược đồ quan hệ (chỉ dùng lại kỹ năng đọc lược đồ và nhận diện khóa chính/ngoại).
- **Chương 3 (T3):** Biểu thức Đại số quan hệ (chỉ nhắc ánh xạ tư duy từ kết ngoài, trừ, giao, chia, gom nhóm sang SQL khi cần).
- **Chương 4 (T4 tr.1–40):** DDL (`CREATE/ALTER/DROP TABLE`, `CHECK`, `FOREIGN KEY`) và DML (`INSERT`, `UPDATE`, `DELETE`).

### Chi tiết các phần thuộc phạm vi Cuối kỳ

| Nguồn | Trang PDF | Nội dung | Mức độ theo 8 mã đề |
|---|---:|---|---|
| T4 | 41–62 | Toán tử, hàm ngày/chuỗi, `SELECT`, `DISTINCT`, `ORDER BY`, kết bằng / `INNER JOIN` | `[TRỌNG TÂM CK]` — Nền tảng cho mọi câu C1.2a–f |
| T4 | 63–67 | Toán tử tập hợp: `UNION`, `INTERSECT`, `EXCEPT` | `[TRỌNG TÂM CK]` — C1.2c/d dạng *"cả hai"*, *"A nhưng không B"*, *"chưa từng"* |
| T4 | 68–81 | Truy vấn lồng: `IN/NOT IN`, `EXISTS/NOT EXISTS`, `ANY/ALL`, **phép chia SQL** | `[TRỌNG TÂM CK]` — **8/8 mã đề** có phép chia ở C1.2e |
| T4 | 82–92 | Hàm tổng hợp (`COUNT/SUM/AVG/MIN/MAX`), `GROUP BY`, `HAVING`, `TOP N / WITH TIES`, phép chia theo `COUNT` | `[TRỌNG TÂM CK]` — **8/8 mã đề** có thống kê/cực trị ở C1.2c/d/f |
| T4 | 93–95 | Kết ngoài: `LEFT / RIGHT / FULL OUTER JOIN` | Quan trọng cho câu *"với mỗi..."* cần giữ đối tượng số lượng `0` và phủ định `IS NULL` |
| T5 | 1–16 | Khái niệm RBTV; 3 đặc trưng: Nội dung hình thức, Bối cảnh, Bảng tầm ảnh hưởng (`+`, `-`, `-(*)`) | `[TRỌNG TÂM CK]` — Khung chấm điểm cố định của **8/8 mã đề** ở C1.1 |
| T5 | 17–52 | Phân loại RBTV trên 1 quan hệ và nhiều quan hệ (trọng tâm: liên thuộc tính–liên quan hệ, liên bộ–liên quan hệ, thuộc tính tổng hợp, chu trình) | `[TRỌNG TÂM CK]` — 8/8 mã đề ra nhóm **nhiều quan hệ** |
| T6 | 1–7 | Bất thường thêm, sửa, xóa | Nền tảng lý thuyết để hiểu mục đích dạng chuẩn |
| T6 | 8–35 | Phụ thuộc hàm, hệ tiên đề Armstrong, bao đóng $F^+$, thuật toán tìm $X^+_F$, bài toán thành viên | `[TRỌNG TÂM CK]` — **8/8 mã đề** ở C2.1 |
| T6 | 36–48 | Định nghĩa khóa/siêu khóa, tập $T, N, TG, \text{Đ}$, thuật toán tìm mọi khóa, PTH riêng phần/đầy đủ/bắc cầu | `[TRỌNG TÂM CK]` — **6/8 mã đề** hỏi trực tiếp C2.2; 2 mã `CK20` vẫn phải tìm khóa để làm 2NF |
| T6 | 49–86 | Dạng chuẩn 1NF, 2NF, 3NF, BCNF và quy trình tìm dạng chuẩn cao nhất | `[TRỌNG TÂM CK]` — **8/8 mã đề** ở C2.2/C2.3 |

### Giới hạn phạm vi đã thống nhất
Đối chiếu toàn bộ slide `T5`, `T6` và 8 mã đề `CK20–CK24` cho thấy **không có nội dung viết SQL Trigger, tìm phủ tối thiểu (canonical cover) hoặc thuật toán phân rã tách bảng về 3NF/BCNF**. Theo xác nhận của người dùng ngày 24/11/2026, lộ trình giữ đúng phạm vi slide và đề gốc; chỉ bổ sung thêm nếu sau này giảng viên thông báo mở rộng.

## 3. Cấu trúc đề Cuối kỳ và tỷ trọng điểm

Cả 8 mã đề đều có thời gian làm bài **90 phút**, không sử dụng tài liệu, tổng **10 điểm**. Từ năm 2022–2023 trở đi (`CK22`, `CK23`, `CK24`), phân bố điểm ổn định ở mốc **1,5 + 6,0 + 2,5**:

| Khối bài | Điểm (`CK22–CK24`) | Điểm (`CK20`) | Tỷ trọng chuẩn hiện hành | Nguồn lý thuyết |
|---|---:|---:|---:|---|
| **C1.1:** Phát biểu chặt chẽ RBTV (bối cảnh, nội dung, bảng tầm ảnh hưởng) | 1,5 | 2,0 | 15% | T5 tr.6–48 |
| **C1.2a–f:** 6 câu truy vấn SQL (mỗi câu 1,0 điểm) | 6,0 | 6,0 | 60% | T4 tr.41–95 |
| **C2:** PTH thành viên (0,75đ) + Tìm mọi khóa (0,75–1,0đ) + Dạng chuẩn (0,75–1,0đ) | 2,5 | 2,0 | 25% | T6 tr.13–86 |

Tỷ trọng trên phản ánh đúng 8 mã đề trong 4 PDF nguồn, không coi là xác suất tuyệt đối của đề sắp thi. Hai mã đề cùng năm dùng chung lược đồ Câu 1 và chung cấu trúc, không coi là hai quan sát hoàn toàn độc lập.

## 4. Lượt A — Ôn tổng quát `CK-R1` đến `CK-R6`

Đi theo thứ tự phụ thuộc kiến thức; phần nào đã vững chỉ cần làm nhanh 1–2 câu tự kiểm rồi chuyển tiếp.

| Bước | Nội dung và thứ tự | Trang nguồn | Mục tiêu kiểm tra ngắn | Gợi ý |
|---|---|---|---|---:|
| **CK-R1** | SQL truy vấn cơ bản, nối nhiều bảng, điều kiện ngày/giờ, `ORDER BY`, kết ngoài | T4 tr.41–62, 93–95 | Viết sạch câu nối 3–4 bảng đúng vai trò khóa ngoại, xử lý đúng `YEAR/MONTH/DATETIME`, phân biệt `INNER` vs `LEFT JOIN` | 20–30 phút |
| **CK-R2** | SQL tập hợp & truy vấn lồng: *"cả hai"*, *"có A nhưng không B"*, *"chưa từng"* | T4 tr.63–78 | Viết được cùng một yêu cầu bằng `INTERSECT`/`EXCEPT` và `EXISTS`/`NOT EXISTS`; tránh bẫy `NOT IN` gặp `NULL` | 25–35 phút |
| **CK-R3** | Phép chia SQL (`NOT EXISTS` 2 tầng / `GROUP BY HAVING`), thống kê `GROUP BY` và cực trị (toàn cục & theo nhóm) | T4 tr.79–92 | Tự dựng đúng phép chia có điều kiện phụ; viết đúng `LEFT JOIN` + `COUNT(cột)` vs `COUNT(*)`; tìm `MIN/MAX` theo từng nhóm | 35–45 phút |
| **CK-R4** | RBTV: phát biểu hình thức bằng logic vị từ, xác định bối cảnh đủ bảng, lập bảng tầm ảnh hưởng với lưu ý *không sửa khóa chính* | T5 tr.6–48 | Phát biểu đủ 3 phần cho 3 dạng hay ra: tổng hợp (`=` / `>=`), tối thiểu $k$, và liên thuộc tính dạng cấm | 30–40 phút |
| **CK-R5** | Phụ thuộc hàm, bao đóng $X^+_F$, bài toán thành viên và thuật toán tìm tất cả các khóa ($T, N, TG$) | T6 tr.13–46 | Tính $X^+_F$ từng bước không sót; lập đúng bảng duyệt $N \cup T \cup X_i$ và loại tập con đúng quy tắc | 25–35 phút |
| **CK-R6** | Dạng chuẩn 1NF, 2NF, 3NF, BCNF và quy trình kiểm tra dạng chuẩn cao nhất | T6 tr.47–86 | Phân biệt thuộc tính khóa vs không khóa; tách vế phải trước khi xét 3NF/BCNF; chỉ đúng PTH vi phạm từng tầng | 25–35 phút |

## 5. Lượt B — Luyện theo dạng và chữa lỗi

1. Dùng [ngân hàng bài tập phản xạ](CK_NGAN_HANG_BAI_TAP_LUYEN_PHAN_XA.md) và [file SQL mẫu](CK_SQL_MAU_THUC_HANH.sql) để làm nóng từng kỹ thuật trước khi đụng đề gốc.
2. Khi luyện đề gốc, ưu tiên từ mới đến cũ: **`CK24` → `CK23` → `CK22` → `CK20`**. Dùng **CK24-Đề1** để luyện từng dạng trước; **giữ lại `CK24-Đề2`** cho lượt thi thử 90 phút.
3. Với SQL C1.2, luyện theo trục tăng độ khó: `a–b` (nối/lọc) → `c` (giao/trừ/lồng) → `d` (gom nhóm/đếm/tổng) → `e` (phép chia) → `f` (cực trị/đối chiếu tổng hợp).
4. Với RBTV C1.1, luyện đủ 3 mẫu: tổng hợp/so sánh số lượng (`CK24`, `CK20`), tối thiểu $k$ (`CK23`), và điều kiện cấm qua bảng trung gian (`CK22`).
5. Với Câu 2, luyện ưu tiên các đề hỏi **dạng chuẩn cao nhất** (`CK24`, `CK22`) trước rồi kiểm lại dạng chỉ hỏi 2NF (`CK23`, `CK20`).

Chi tiết phân loại từng mã đề xem tại [bản đồ đề thi Cuối kỳ](CK_BAN_DO_DE_THI_CSDL.md).

## 6. Lượt C — Đề tổng hợp 90 phút

Giữ **`CK24-Đề2`** (hoặc `CK23-Đề2` nếu muốn thêm một lượt 90 phút) để bấm giờ làm trọn vẹn **90 phút**, không mở tài liệu. Gợi ý phân bổ thời gian khởi đầu:
- **5 phút:** Đọc toàn bộ lược đồ Câu 1, gạch chân khóa chính/ngoại, vẽ nháp đường nối giữa các bảng.
- **15 phút:** Làm Câu 1.1 (RBTV) — soát lại bối cảnh và cột Sửa với lưu ý *không sửa khóa chính*.
- **45 phút:** Làm Câu 1.2a–f (6 câu SQL, trung bình 6–8 phút/câu; làm chắc `a, b, c, d` trước rồi `e, f`).
- **20 phút:** Làm Câu 2 (PTH thành viên → Tìm mọi khóa → Dạng chuẩn cao nhất) — kiểm tra lại bao đóng từng khóa.
- **5 phút:** Soát lại alias, tên cột hiển thị đúng yêu cầu đề, dấu ngoặc và điều kiện `GROUP BY`.

## 7. Chỗ cần cẩn thận khi tra nguồn Cuối kỳ

- **Khóa chính gạch chân trong đề gốc:** Text trích xuất không giữ định dạng gạch chân; đã kiểm chứng ảnh gốc trang 1 của cả 4 PDF tại `tmp/study_audit/visuals/CK*-p1.png`. Các bảng có khóa ghép cần đặc biệt chú ý là `PHUTRACH(MABS, MAKB)` (`CK20`), `THAMGIADT(MaNV, MaDT)` và `CONGBOBB(MaNV, MaBB)` (`CK23`).
- **Ký hiệu mũi tên và toán tử trong text trích xuất:** Một số PDF mã hóa mũi tên `→` thành `®` (`CK24`) hoặc ký tự font Symbol (`T5`, `CK23`), và bảng tầm ảnh hưởng trong `T5` bị xáo dòng khi xuất text thô. Đã đối chiếu ảnh gốc các trang trọng yếu (`T5` tr.16/35/39/40/47, `T6` tr.39, `CK23–CK24` tr.2/4).
- **Mức chi tiết của đề SQL:** Khi đề hỏi *"với mỗi..."* (`CK24-Đề2 C1.2d`, `CK23 C1.2f`, `CK22 C1.2c`, `CK20 C1.2c`), cần xác định rõ có cần giữ đối tượng số lượng `0` bằng `LEFT JOIN` hay không và nêu giả thiết ngắn nếu đề không ghi rõ.
- **Lưu ý trong Câu 2 `CK24`:** Đề ghi *"thành viên của F"* nhưng ngữ nghĩa chuẩn bài toán thành viên theo `T6 tr.22, 29` là kiểm tra thuộc bao đóng $F^+$ ($X \to Y \in F^+ \iff Y \subseteq X^+_F$).
