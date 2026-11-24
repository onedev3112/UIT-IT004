# Ôn thi Cơ sở dữ liệu — UIT (IT004)

Thư mục ôn thi Giữa kỳ và Cuối kỳ dành cho người đã có kiến thức sơ bộ: ôn tổng quát, kiểm tra chỗ hổng rồi luyện đề và chữa lỗi.

## Điều hướng nhanh

- [Mốc hiện tại](memory.md): đọc khi tiếp tục buổi ôn.
- [Quy tắc làm việc](AGENTS.md): cách dùng nguồn, đọc ít context và ghi tiến độ.
- [Nhật ký ôn tập](memory/nhat-ky-on-tap.md): chỉ ghi kết quả thực tế sau mỗi lượt học/luyện.
- [Dữ liệu trích xuất dùng lại](tmp/study_audit/README.md): tra đúng trang cho cả 13 PDF, tránh mở và trích lại toàn bộ.

### Bộ tài liệu Cuối kỳ (giai đoạn hiện tại)
- [Phạm vi và thứ tự ôn Cuối kỳ](output/CK_PHAM_VI_VA_THU_TU_ON_CSDL.md): nguồn `T4` (tr.41–95), `T5`, `T6`, ma trận 4 PDF đề Cuối kỳ và lộ trình `CK-R1`–`CK-R6`.
- [Bản đồ đề Cuối kỳ](output/CK_BAN_DO_DE_THI_CSDL.md): 4 PDF (`CK24`, `CK23`, `CK22`, `CK20`), 8 mã đề (90 phút/đề), phân loại dạng không kèm đáp án làm sẵn.
- [Lý thuyết trọng tâm & Bẫy đề thi Cuối kỳ](output/CK_TONG_HOP_LY_THUYET_VA_BAY_DE_THI.md): tóm tắt trực diện gắn thẻ `[TRỌNG TÂM CK]` và danh mục bẫy mất điểm tự luận.
- [Quy trình giải chuẩn Cuối kỳ](output/CK_QUY_TRINH_GIAI_CHUAN.md): quy trình từng bước cho RBTV, 6 dạng SQL và PTH/Khóa/Dạng chuẩn.
- [Ngân hàng bài tập phản xạ](output/CK_NGAN_HANG_BAI_TAP_LUYEN_PHAN_XA.md) & [File SQL mẫu thực hành](output/CK_SQL_MAU_THUC_HANH.sql): bài tập tự soạn phân biệt rõ với đề gốc, kèm lời giải chi tiết và script MS SQL Server chạy thử.

### Bộ tài liệu Giữa kỳ (đã lưu trữ)
- [Phạm vi và thứ tự ôn Giữa kỳ](output/PHAM_VI_VA_THU_TU_ON_CSDL.md) & [Bản đồ đề Giữa kỳ](output/BAN_DO_DE_THI_CSDL.md).
- [Bảng từ khóa & cách làm ĐSQH](output/DSQH_BANG_TU_KHOA_VA_CACH_LAM_TONG_QUAT.md), [Ôn hội/giao/trừ/chia](output/ON_DSQH_HOI_GIAO_TRU_CHIA.md), [Tự kiểm DDL](output/TU_KIEM_DDL_01.md), [Tự luyện Câu 2](output/TU_LUYEN_CAU_2_TONG_HOP_01.md).

## Tổ chức thư mục

- `Lý thuyết/`, `Giữa kỳ/`, `Cuối kỳ/`: 13 PDF nguồn, giữ nguyên.
- `output/`: tài liệu phạm vi, bản đồ đề (không chứa đáp án đề gốc), lý thuyết trọng tâm, quy trình giải và bài tự luyện/SQL tự soạn.
- `memory/`: nhật ký chi tiết khi thực sự ôn.
- `tmp/study_audit/`: chữ theo trang (`T1–T6`, `E23–E25`, `CK20/22/23/24`), manifest, chỉ mục câu hỏi và ảnh đối chiếu gốc.

## Lịch sử chuẩn bị

### 24/11/2026 — Chuẩn bị bộ tài liệu ôn Cuối kỳ
Đã kiểm kê thêm 6 PDF mới (`T5` 53 tr., `T6` 87 tr., và 4 PDF `Cuối kỳ/` gồm 8 mã đề / 18 tr.), mở rộng phạm vi sang phần truy vấn SQL của `T4` (tr.41–95), trích xuất và đối chiếu hình gốc khóa chính/ký hiệu toán, đồng thời tạo trọn bộ 6 tài liệu Cuối kỳ trong `output/` cùng chỉ mục `ck_question_index.json`. Đây là bước chuẩn bị; chưa đánh dấu người dùng đã ôn hoặc làm đúng câu Cuối kỳ nào.

### 27/10/2026 — Chuẩn bị thư mục ôn tập Giữa kỳ
Đã kiểm kê bảy PDF (`T1–T4`, `E23–E25`), lưu trích xuất của 296 trang và đối chiếu sáu mã đề Giữa kỳ.
