# Trích xuất và đối chiếu nguồn CSDL

Cache để dùng lại toàn bộ 13 PDF nguồn đã chọn (Giữa kỳ + Cuối kỳ); không phải nơi ghi tiến độ. Mốc học ở [memory.md](../../memory.md), phạm vi Giữa kỳ ở [tài liệu GK](../../output/PHAM_VI_VA_THU_TU_ON_CSDL.md), phạm vi Cuối kỳ ở [tài liệu CK](../../output/CK_PHAM_VI_VA_THU_TU_ON_CSDL.md).

## Nội dung

- `manifest.json`: danh sách 13 nguồn cố định (`T1–T6`, `E23–E25`, `CK20/22/23/24`), SHA256 PDF/cache, số trang và phiên bản bộ trích xuất. Đường dẫn `source` tính từ gốc CSDL, dùng được khi di chuyển cả thư mục.
- `T1.txt`–`T6.txt`, `E23.txt`–`E25.txt`, `CK20.txt`, `CK22.txt`, `CK23.txt`, `CK24.txt`: chữ theo trang, nhãn `[PDF PAGE N]` là trang vật lý PDF đếm từ 1.
- Các file `.json` cùng mã: danh sách `{page, text, chars}`, dễ đọc đúng trang mà không nạp cả tài liệu.
- `question_index.json`: chỉ mục 62 yêu cầu nhỏ của 6 mã đề Giữa kỳ (`E23–E25`).
- `ck_question_index.json`: chỉ mục 78 yêu cầu nhỏ của 8 mã đề Cuối kỳ (`CK20`, `CK22`, `CK23`, `CK24`). Không chứa đáp án hoặc kết quả học.
- `visuals/`: ảnh đối chiếu các trang đề Giữa kỳ (`E23–E25`), các trang trọng yếu của `T1–T6` và các trang lược đồ/đề Cuối kỳ (`CK20`, `CK22`, `CK23`, `CK24`) để kiểm khóa gạch chân, ký hiệu logic, mũi tên PTH và bảng tầm ảnh hưởng.
- `extract_sources.py`: trích đúng 13 nguồn cố định. Nếu SHA256 nguồn, phiên bản và cache còn khớp thì tái sử dụng; không đọc lại PDF.

## Cách dùng

Ưu tiên mở đúng mã/trang từ TXT/JSON, không mở tất cả cache trước mỗi lượt. Ví dụ tìm `\[PDF PAGE 39\]` trong `T5.txt` để tra RBTV thuộc tính tổng hợp, hoặc `\[PDF PAGE 55\]` trong `T6.txt` để tra kiểm tra 2NF. Khi cần kiểm cache hoặc nguồn thay đổi, chạy script từ thư mục CSDL bằng Python có `pypdf` (hoặc `uv run --with pypdf`):

```powershell
uv run --with pypdf python .\tmp\study_audit\extract_sources.py --verify-only
uv run --with pypdf python .\tmp\study_audit\extract_sources.py
```

Không chạy lệnh trích xuất theo thói quen mỗi lượt. `--verify-only` chỉ đọc hash, không trích PDF hay ghi cache. Chỉ chạy lại khi thực sự thêm/đổi nguồn hoặc nghi cache hỏng; nếu nguồn đổi phải xem lại phạm vi/chỉ mục.

## Chất lượng trích xuất

Cả 13 PDF đều có lớp chữ, không cần OCR để có bản đọc đầu. Một số trang có hiện tượng ghép chữ tiếng Việt, mất gạch chân khóa chính, sai ký hiệu mũi tên (`®` trong `CK24`, ký hiệu Symbol trong `T5`/`CK23`) hoặc xáo vị trí cột bảng tầm ảnh hưởng trong `T5`. Khi thông tin đó ảnh hưởng lời giải, xem ảnh trong `visuals/` hoặc PDF gốc thay vì suy đoán.

Các ảnh đã đối chiếu trực tiếp gồm:
- Giữa kỳ: đủ 12 trang `E23–E25` và các trang `T1:52`, `T2:25`, `T3:37/51/56`, `T4:22/35/40/41`.
- Cuối kỳ: `T5:13/15/16/35/39/40/44/47`, `T6:39/41/75`, `CK20:1/3/4/6`, `CK22:1/2/4`, `CK23:1/2/4`, `CK24:1/2/4`.
