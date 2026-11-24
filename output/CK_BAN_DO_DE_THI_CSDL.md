# Bản đồ đề Cuối kỳ Cơ sở dữ liệu

Đối chiếu ngày 24/11/2026 từ bốn PDF `CK24`, `CK23`, `CK22`, `CK20` trong [phạm vi Cuối kỳ](CK_PHAM_VI_VA_THU_TU_ON_CSDL.md). Chỉ mục máy đọc lưu tại `../tmp/study_audit/ck_question_index.json` (78 yêu cầu nhỏ, tổng 80 điểm của 8 mã đề). **Không chứa đáp án hoặc lời giải làm sẵn ở đây.**

## 1. Tám mã đề trong bốn PDF

Mỗi mã đề thời gian **90 phút**, tổng **10 điểm**, gồm Câu 1 (RBTV + 6 câu SQL) và Câu 2 (PTH, khóa, dạng chuẩn). Khóa chính dưới đây đã đối chiếu trực tiếp trên ảnh gốc trang đề.

| Mã dùng khi luyện | Trang PDF | Ngữ cảnh Câu 1 | Các quan hệ & Khóa chính (đã kiểm hình gốc) | Phân bố điểm |
|---|---:|---|---|---|
| **CK24-Đề1** | 1–2 | Đặt vé máy bay nội địa | `SANBAY(MaSB)`, `CHUYENBAY(SoHieuCB)`, `LICHBAY(MaLB)`, `LOAIVE(MaLV)`, `THANHVIEN(MaTV)`, `DATVE(MaDV)`, `CTDV(MaCTDV)` | 1,5 + 6,0 + 2,5 |
| **CK24-Đề2** | 3–4 | Đặt vé máy bay nội địa | *(như trên)* | 1,5 + 6,0 + 2,5 |
| **CK23-Đề1** | 1–2 | Quản lý NCKH UIT | `PHONG(MaPhong)`, `NHANVIEN(MaNV)`, `DETAI(MaDT)`, `THAMGIADT(MaNV, MaDT)`, `BAIBAOKH(MaBB)`, `CONGBOBB(MaNV, MaBB)` | 1,5 + 6,0 + 2,5 |
| **CK23-Đề2** | 3–4 | Quản lý NCKH UIT | *(như trên)* | 1,5 + 6,0 + 2,5 |
| **CK22-Đề1** | 1–2 | Bán căn hộ trả góp | `KHACHHANG(MAKH)`, `LOAICH(MALCH)`, `CANHO(MACH)`, `HINHTHUCTG(MAHT)`, `TRAGOP(MATG)` | 1,5 + 6,0 + 2,5 |
| **CK22-Đề2** | 3–4 | Bán căn hộ trả góp | *(như trên)* | 1,5 + 6,0 + 2,5 |
| **CK20-Đề1** | 1–3 | Hồ sơ bệnh án điện tử | `BENHNHAN(MABN)`, `KHAMBENH(MAKB)`, `PHAUTHUAT(MAPT)`, `BACSI(MABS)`, `PHUTRACH(MABS, MAKB)` | 2,0 + 6,0 + 2,0 |
| **CK20-Đề2** | 4–6 | Hồ sơ bệnh án điện tử | *(như trên)* | 2,0 + 6,0 + 2,0 |

## 2. Phần Ràng buộc toàn vẹn — Câu 1.1

Tất cả 8/8 mã đề đều yêu cầu phát biểu đủ **bối cảnh, nội dung, bảng tầm ảnh hưởng** và đều có lưu ý **không được sửa thuộc tính khóa chính**.

| Mã đề | Trang | Tóm tắt yêu cầu RBTV | Nhóm phân loại theo T5 | Bảng liên quan trực tiếp |
|---|---:|---|---|---|
| **CK24-Đề1** | 2 | `SLVeKT` của lịch bay $\ge$ tổng `SLVeToiDa` các loại vé thuộc lịch bay đó | Liên quan hệ + tổng hợp (`SUM`, bất đẳng thức `>=`) | `LICHBAY`, `LOAIVE` |
| **CK24-Đề2** | 4 | `SLVeToiDa` của loại vé $\ge$ số lượng chi tiết đặt vé đã đặt loại vé đó | Liên bộ–liên quan hệ (`COUNT`, bất đẳng thức `>=`) | `LOAIVE`, `CTDV` |
| **CK23-Đề1** | 2 | Đề tài cấp ĐHQG-HCM đã nghiệm thu phải có tối thiểu 2 bài báo | Liên bộ–liên quan hệ (có điều kiện lọc + `COUNT >= 2`) | `DETAI`, `BAIBAOKH` |
| **CK23-Đề2** | 4 | Đề tài cấp trường có kinh phí > 100.000.000 phải có tối thiểu 5 nhân viên tham gia | Liên bộ–liên quan hệ (có điều kiện lọc + `COUNT >= 5`) | `DETAI`, `THAMGIADT` |
| **CK22-Đề1** | 2 | Căn hộ diện tích > 50m² không được trả góp với kỳ hạn < 24 tháng | Liên thuộc tính–liên quan hệ dạng cấm (qua bảng giao dịch) | `CANHO`, `HINHTHUCTG`, `TRAGOP` |
| **CK22-Đề2** | 4 | Căn hộ số phòng $\le$ 3 không được trả góp với kỳ hạn > 36 tháng | Liên thuộc tính–liên quan hệ dạng cấm (qua bảng giao dịch) | `CANHO`, `HINHTHUCTG`, `TRAGOP` |
| **CK20-Đề1** | 1–2 | `SLPT` của bệnh nhân $=$ số lần phẫu thuật chỉ định qua các lần khám của bệnh nhân đó | Thuộc tính tổng hợp qua bảng trung gian (`COUNT`, `=`) | `BENHNHAN`, `KHAMBENH`, `PHAUTHUAT` |
| **CK20-Đề2** | 4–5 | *(Cùng nội dung yêu cầu như CK20-Đề1)* | Thuộc tính tổng hợp qua bảng trung gian (`COUNT`, `=`) | `BENHNHAN`, `KHAMBENH`, `PHAUTHUAT` |

## 3. Phần Truy vấn SQL — Câu 1.2a–f (6 điểm / mã đề)

| Mã đề | a | b | c | d | e *(8/8 phép chia)* | f *(tổng hợp / cực trị)* |
|---|---|---|---|---|---|---|
| **CK24-Đề1** | Nối 2 bảng, lọc `TTKhaiThac`, `ORDER BY ASC` | Nối 3 bảng, lọc tên sân bay đi & `GioDi` cụ thể | Giao / tồn tại đồng thời: *"Đã thanh toán"* và đặt cả *"Thương gia"* lẫn *"Phổ thông"* (2024) | Thống kê `COUNT` chi tiết đặt vé theo từng loại vé của `"VN121"` (2024) | Thành viên đã thanh toán đặt **tất cả** loại vé của lịch bay `"VN101-080125"` trong lần đặt đó | Lịch bay khởi hành từ `"SGN"` (2025) đã **đặt hết vé** (so sánh `SUM`/`COUNT` với `SLVeKT`) |
| **CK24-Đề2** | Nối 2 bảng, lọc sinh nhật tháng 12, `ORDER BY DESC` | Nối 3 bảng, lọc tên sân bay đến & `GioDen` cụ thể | Trừ / `NOT EXISTS`: đặt vé năm 2024 nhưng **chưa từng** đặt `"Thương gia"` giá > 10 triệu | **Với mỗi sân bay**, tổng `SLVe` đặt trong 12/2024 theo sân bay khởi hành | Lượt đặt vé đặt **tất cả** loại vé của lịch bay `"VN602"` lúc `08:15:00 08/01/2025` | Loại vé của chuyến `"VN330"` (2025) đã **đặt hết** (so sánh `COUNT` với `SLVeToiDa`) |
| **CK23-Đề1** | Nối 2 bảng, lọc nhiệm vụ phòng, `ORDER BY DESC` | Nối 3 bảng, lọc năm 2023 & vai trò `"chủ nhiệm"` | Trừ / `NOT EXISTS`: đã công bố bài báo nhưng **không là** `"tác giả chính"` bài nào | Thống kê `COUNT` bài báo theo từng đề tài công bố năm 2023 | Nhân viên công bố **tất cả** bài báo `"tạp chí quốc tế"` của `"DT01"` | **Với mỗi phòng**, nhân viên tham gia **ít đề tài nhất** (cực trị theo nhóm) |
| **CK23-Đề2** | Nối 2 bảng, lọc vai trò `"chủ nhiệm"`, `ORDER BY ASC` | Nối 3 bảng, lọc `"tạp chí quốc tế"` & `"tác giả chính"` | Giao / tự kết: vừa là `"tác giả chính"` bài này, vừa là `"đồng tác giả"` **bài khác** | Thống kê `COUNT` đề tài theo từng nhân viên với vai trò `"chủ nhiệm"` | Nhân viên công bố **tất cả** bài báo `"hội nghị quốc tế"` của `"DT02"` | **Với mỗi phòng**, nhân viên công bố **ít bài báo nhất** (cực trị theo nhóm) |
| **CK22-Đề1** | Nối 2 bảng, lọc `YEAR` 1980–1985 & ngày `'1/2/2023'` | Nối 3 bảng, diện tích > 80m², `ORDER BY DESC` | Thống kê `COUNT` căn hộ trong từng loại căn hộ | Trừ / `EXCEPT`: trả góp `"cao cấp"` **nhưng không** trả góp `"trung cấp"` | Khách mua trả góp **tất cả** căn hộ `"penthouse"` nhóm `"cao cấp"` | Loại căn hộ nhóm `"cao cấp"` năm 2022 có số lượt bán trả góp **> 10** (`HAVING`) |
| **CK22-Đề2** | Nối 2 bảng, lọc `"shophouse"` & giá `BETWEEN` | Nối 3 bảng, kỳ hạn > 120 tháng, `ORDER BY DESC` | Thống kê `COUNT` căn hộ trả góp theo từng hình thức | Giao / `INTERSECT`: trả góp cả `"penthouse"` **và** `"duplex"` | Khách mua trả góp **tất cả** căn hộ `"duplex"` nhóm `"cao cấp"` | Khách năm 2019 có tổng `SOTIENTT` căn hộ 4 phòng **> 900.000.000** (`HAVING SUM`) |
| **CK20-Đề1** | Lọc 1 bảng `OR`, `ORDER BY SLPT DESC` | Nối 2 bảng, sinh sau 2020 & bệnh `"Tim mạch"` | Thống kê `COUNT` lần khám theo từng bệnh nhân (2020) | Trừ / `NOT EXISTS`: bác sĩ `"Tai-Mũi-Họng"` **chưa** phụ trách năm 2020 | Bác sĩ `"Hồi sức - Cấp cứu"` tham gia **tất cả** mã khám của `"Nguyễn Văn A"` | Bác sĩ có số lần phụ trách khám **nhiều nhất** (cực trị toàn cục) |
| **CK20-Đề2** | Lọc 1 bảng `OR`, `ORDER BY MABN ASC` | Nối 2 bảng, chuyên môn `"Tim mạch"` & từ năm 2021 | Thống kê `COUNT` lần phụ trách theo từng bác sĩ (2020) | Giao / `INTERSECT`: bệnh nhân chẩn đoán cả `"Viêm phổi"` **và** `"Tim mạch"` có tái khám 2021 | Bác sĩ khoa `"Cấp cứu"` tham gia **tất cả** mã khám có phẫu thuật `"Phổi"` | Bệnh nhân có số lần khám bệnh **nhiều nhất** (cực trị toàn cục) |

## 4. Phần Phụ thuộc hàm và Dạng chuẩn — Câu 2 (2,0–2,5 điểm / mã đề)

| Mã đề | Trang | Tập thuộc tính $U$ & Tập PTH $F$ | Ý 2.1 (Thành viên) | Ý 2.2 (Khóa) | Ý 2.3 (Dạng chuẩn) |
|---|---:|---|---|---|---|
| **CK24-Đề1** | 2 | $U=\{A,B,C,D,E,G,H,I\}$; $F=\{B\to E,\; BD\to IG,\; GE\to CH,\; DE\to BC,\; G\to A\}$ | $BG\to AI \in F^+$? (0,75đ) | Tìm tất cả khóa (0,75đ) | Dạng chuẩn cao nhất (1,0đ) |
| **CK24-Đề2** | 4 | $U=\{A,B,C,D,E,G,H,I\}$; $F=\{D\to E,\; DH\to IB,\; BE\to CG,\; HE\to DC,\; B\to A\}$ | $BD\to AG \in F^+$? (0,75đ) | Tìm tất cả khóa (0,75đ) | Dạng chuẩn cao nhất (1,0đ) |
| **CK23-Đề1** | 2 | $U=\{A,B,C,D,E,G,H,I\}$; $F=\{AC\to E,\; B\to H,\; BE\to CG,\; DE\to A,\; AE\to IB\}$ | $AC\to DG \in F^+$? (0,75đ) | Tìm tất cả khóa (1,0đ) | Đạt 2NF không? (0,75đ) |
| **CK23-Đề2** | 4 | $U=\{A,B,C,D,E,G,H,I\}$; $F=\{BD\to G,\; C\to I,\; CG\to DH,\; EG\to B,\; BG\to AC\}$ | $BD\to EG \in F^+$? (0,75đ) | Tìm tất cả khóa (1,0đ) | Đạt 2NF không? (0,75đ) |
| **CK22-Đề1** | 2 | $U=\{A,B,C,D,E,G,H\}$; $F=\{AE\to BH,\; B\to E,\; ABH\to CD,\; AB\to G,\; EH\to B\}$ | $AB\to DG \in F^+$? (0,75đ) | Tìm tất cả khóa (1,0đ) | Dạng chuẩn cao nhất (0,75đ) |
| **CK22-Đề2** | 4 | $U=\{A,B,C,D,E,I,K\}$; $F=\{A\to I,\; CI\to AK,\; IK\to A,\; AC\to D,\; ACK\to BE\}$ | $CI\to DE \in F^+$? (0,75đ) | Tìm tất cả khóa (1,0đ) | Dạng chuẩn cao nhất (0,75đ) |
| **CK20-Đề1** | 3 | $U=\{A,B,C,D,E\}$; $F=\{A\to BC,\; A\to E,\; BC\to AD,\; AB\to D\}$ | $BDC\to E \in F^+$? (0,75đ) | *(tìm khóa trong bước xét 2NF)* | Đạt 2NF không? (1,25đ) |
| **CK20-Đề2** | 6 | $U=\{A,B,C,D,E\}$; $F=\{D\to BC,\; D\to E,\; BC\to AD,\; DB\to A\}$ | $BAC\to E \in F^+$? (0,75đ) | *(tìm khóa trong bước xét 2NF)* | Đạt 2NF không? (1,25đ) |

## 5. Thứ tự luyện từng dạng (ưu tiên `CK24 → CK23 → CK22 → CK20`)

| Dạng bài | Câu nên bắt đầu | Câu bổ sung biến thể | Bước ôn tương ứng |
|---|---|---|---|
| SQL lọc, nối nhiều bảng, ngày/giờ, sắp xếp | `CK24-Đề1 C1.2a,b` | `CK23-Đề1 C1.2a,b`, `CK22-Đề1 C1.2a,b` | CK-R1 |
| SQL *"cả hai"*, *"A nhưng không B"*, *"chưa từng"* | `CK24-Đề1 C1.2c` (cả hai); `CK23-Đề1 C1.2c` (phủ định) | `CK23-Đề2 C1.2c` (2 bài **khác nhau**), `CK22-Đề1 C1.2d`, `CK20-Đề1 C1.2d` | CK-R2 |
| SQL thống kê `GROUP BY` / `LEFT JOIN` / `HAVING` | `CK24-Đề1 C1.2d` | `CK23-Đề1 C1.2d`, `CK22-Đề1 C1.2c,f`, `CK22-Đề2 C1.2f` | CK-R1, CK-R3 |
| **Phép chia trong SQL** (*"tất cả..."*) | `CK24-Đề1 C1.2e` | `CK23-Đề1 C1.2e`, `CK22-Đề1 C1.2e`, `CK20-Đề1 C1.2e` | CK-R3 |
| SQL cực trị toàn cục / cực trị theo nhóm / đối chiếu tổng hợp | `CK24-Đề1 C1.2f` (hết vé); `CK23-Đề1 C1.2f` (ít nhất **mỗi phòng**) | `CK23-Đề2 C1.2f`, `CK20-Đề1 C1.2f` (nhiều nhất toàn cục) | CK-R3 |
| RBTV thuộc tính tổng hợp & so sánh tổng/đếm | `CK24-Đề1 C1.1` (`SUM`, `>=`) | `CK20-Đề1 C1.1` (`COUNT`, `=` qua bảng trung gian) | CK-R4 |
| RBTV liên bộ–liên quan hệ tối thiểu $k$ | `CK23-Đề1 C1.1` | `CK23-Đề2 C1.1` | CK-R4 |
| RBTV liên thuộc tính–liên quan hệ dạng cấm | `CK22-Đề1 C1.1` | `CK22-Đề2 C1.1` | CK-R4 |
| PTH thành viên, tìm mọi khóa, dạng chuẩn cao nhất | `CK24-Đề1 C2.1–2.3` | `CK22-Đề1 C2.1–2.3`, `CK23-Đề1 C2.1–2.3`, `CK20-Đề1 C2.1–2.2` | CK-R5, CK-R6 |

Giữ **`CK24-Đề2`** cho lượt làm thử 90 phút cuối cùng. Chưa có mã đề Cuối kỳ nào được đánh dấu đã làm.
