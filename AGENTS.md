# Quy tắc ôn thi CSDL

Người dùng đã có kiến thức sơ bộ. Ưu tiên ôn tổng quát rồi luyện đề, chữa đúng chỗ hổng; không mặc định dạy lại từ đầu. Thư mục dùng theo đợt ôn thi.

## Đọc theo nhu cầu

- Khi tiếp ôn hoặc hỏi tiến độ, đọc `memory.md` nếu chưa có bản mới nhất. Chỉ mở mục liên quan trong `output/` hoặc `memory/nhat-ky-on-tap.md`; không nạp toàn bộ lịch sử.
- Tra `output/CK_PHAM_VI_VA_THU_TU_ON_CSDL.md` (giai đoạn hiện tại — Cuối kỳ) hoặc `output/PHAM_VI_VA_THU_TU_ON_CSDL.md` (Giữa kỳ) để biết bước/trang; tra `output/CK_BAN_DO_DE_THI_CSDL.md` hoặc `output/BAN_DO_DE_THI_CSDL.md` để chọn câu. Chỉ đọc đúng trang trong `tmp/study_audit/T1.txt` đến `T6.txt` hoặc `E23–E25.txt`, `CK20/22/23/24.txt`.
- Dùng lại cache đã đối chiếu. Chỉ trích lại khi PDF hoặc cache thay đổi/hỏng; xem trang PDF gốc khi cần hình, gạch chân khóa, ký hiệu toán hoặc chữ bị ghép/mất. Không chạy OCR lại khi bản chữ đang dùng đủ rõ.

## Nguồn và giới hạn

- **Kiến thức lấy chính từ sáu PDF lý thuyết người dùng gửi** (`T1`–`T6`). **Đề chuẩn để luyện và xếp trọng tâm chỉ lấy từ các PDF đã gửi:** Giữa kỳ (`E23`/`E24`/`E25`) và Cuối kỳ (`CK20`/`CK22`/`CK23`/`CK24`). Tên và đường dẫn chính xác ở tài liệu phạm vi và `tmp/study_audit/manifest.json`; không tự thêm đề mạng, đề mẫu, ngân hàng hay đáp án ngoài vào căn cứ.
- **Giai đoạn hiện tại — Cuối kỳ (cập nhật 24/11/2026):** Phạm vi gồm `T4` trang PDF **41–95** (Ngôn ngữ truy vấn dữ liệu SQL), `T5` (toàn chương RBTV, 53 tr.) và `T6` (toàn chương PTH & Dạng chuẩn 1NF–BCNF, 87 tr.). Không lặp lại nội dung đã thi Giữa kỳ (`T1–T3` và `T4` tr.1–40). Theo xác nhận ngày 24/11/2026, bám sát đúng slide và 8 mã đề `CK20–CK24`; chưa bổ sung Trigger, phủ tối thiểu hoặc phân rã tách bảng trừ khi người dùng yêu cầu thêm.
- **Ưu tiên đề mới nhất:** với Cuối kỳ ưu tiên `CK24` (2024–2025) → `CK23` → `CK22` → `CK20` (giữ `CK24-Đề2` cho lượt 90 phút nếu chưa làm trước đó); với Giữa kỳ (đã lưu trữ) ưu tiên `E25` → `E24` → `E23`.
- Chỉ dùng phần câu hỏi từ đề gốc. Không đưa trước lời giải khi người dùng đang làm đề gốc. Câu tự soạn (kể cả `output/CK_NGAN_HANG_BAI_TAP_LUYEN_PHAN_XA.md` và `output/CK_SQL_MAU_THUC_HANH.sql`) chỉ là luyện phản xạ/tự kiểm, phải phân biệt với đề gốc và không tính thành bằng chứng tần suất.
- Giới hạn trên là phạm vi làm việc dựa trên yêu cầu và đề đã gửi, chưa phải xác nhận chính thức về đề sắp thi. Khi người dùng cung cấp giới hạn mới, đối chiếu rồi cập nhật.
- Nếu PDF thiếu/sai/mơ hồ, chỉ rõ vị trí. Nguồn chính thống bên ngoài chỉ dùng bổ sung có nhãn, không thay nguồn chính hoặc tự mở rộng phạm vi. Không suy đoán khóa/bản số từ text thiếu gạch chân hay từ tên thuộc tính.

## Cách ôn và lưu tiến độ

- Với Cuối kỳ: ôn theo lộ trình `CK-R1` đến `CK-R6` rồi luyện từng dạng, sau đó làm đề 90 phút (với Giữa kỳ trước đây là `R1–R8` và 75 phút). Kiểm tra ngắn để tìm chỗ hổng; phần người dùng làm được thì chuyển tiếp, không ép lặp lại toàn bộ lý thuyết.
- Phân biệt kiến thức tự đánh giá, nội dung đã nhắc lại, câu đã trả lời, đã chữa và đã thành thạo. Không gán % thành thạo, điểm hay kết quả cho câu chưa làm.
- Giữ nguyên tên bảng, thuộc tính, ngày, điều kiện và mã đề khi giao/chấm. Chấp nhận biểu thức tương đương về ngữ nghĩa; nêu giả thiết khi đề không đủ rõ. Cú pháp SQL ưu tiên MS SQL Server theo T4.
- `memory.md` chỉ giữ mốc hiện tại, câu đang chờ, bài tiếp và liên kết. Kết quả/lỗi cụ thể ghi một lần trong nhật ký; không chép bài giảng hoặc đồng bộ tiến độ vào README/cache.
- Giữ nguyên PDF nguồn; không tự đặt lịch, bắt đầu giảng/luyện khi đang chỉ chuẩn bị thư mục, hoặc mang tiến độ/quỹ giờ của môn khác sang CSDL.
