# Ứng dụng web phát nhạc / streaming nhạc - Use Case Specification

## 1. Use Case Diagram (tổng quan)

```mermaid
usecaseDiagram
actor User as U
actor Admin as A
actor "Audio CDN/Player" as CDN

U --> (Đăng ký/Đăng nhập)
U --> (Tìm kiếm nội dung)
U --> (Trang bài hát)
U --> (Phát nhạc)
U --> (Quản lý Playlist)
U --> (Yêu thích bài hát)
U --> (Theo dõi Nghệ sĩ/Album)
U --> (Xem Lịch sử & Thống kê)

(Phát nhạc) --> CDN : HLS/DASH

A --> (Quản lý Nghệ sĩ)
A --> (Quản lý Album)
A --> (Quản lý Track)
A --> (Quản lý Genre)
A --> (Upload demo & set Streaming URL)
```

**Actor:** User, Admin, Audio CDN/Player (external system cung cấp stream HLS/DASH)

## 2. Nhóm Use Case & Mô tả chi tiết

### UC-01: Đăng ký/Đăng nhập

**Brief:** Người dùng tạo tài khoản và đăng nhập bằng email+OTP hoặc SSO.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Có mạng; với SSO: nhà cung cấp SSO hoạt động |
| **Postconditions** | Phiên đăng nhập hợp lệ; tạo hồ sơ User nếu mới |
| **Basic Flow** | (1) Mở trang Auth → (2) Chọn Email/OTP hoặc SSO → (3) Xác thực thành công → (4) Vào trang chủ |
| **Alternate Flows** | A1: OTP hết hạn → gửi lại OTP. A2: SSO thất bại → hiển thị lỗi & cho chọn phương thức khác. |

### UC-02: Tìm kiếm nội dung

**Brief:** Tìm bài hát/nghệ sĩ/album/playlist theo từ khóa, lọc/sort.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Đã truy cập ứng dụng; có dữ liệu được index |
| **Postconditions** | Hiển thị danh sách kết quả, có thể điều hướng vào trang chi tiết |
| **Basic Flow** | (1) Nhập từ khóa → (2) Chọn loại (All/Track/Artist/Album/Playlist) → (3) Xem kết quả → (4) Nhấp để mở chi tiết |
| **Alternate Flows** | A1: Không có kết quả → gợi ý từ khóa liên quan/đề xuất hot. |

### UC-03: Trang bài hát

**Brief:** Hiển thị ảnh bìa, metadata, lời bài hát (lyrics), gợi ý liên quan.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Track tồn tại & cho phép public |
| **Postconditions** | Người dùng có thể phát nhạc/tương tác (like, thêm playlist) |
| **Basic Flow** | (1) Mở trang track → (2) Tải metadata + lyrics → (3) Hiển thị đề xuất liên quan |
| **Alternate Flows** | A1: Lyrics chưa có → hiển thị "Chưa có lời bài hát". A2: Track không public → báo không khả dụng. |

### UC-04: Phát nhạc (Play/Pause/Seek/Next/Prev, Shuffle/Repeat)

**Brief:** Trình phát tương tác với Audio CDN qua HLS/DASH.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User; Audio CDN/Player |
| **Preconditions** | URL streaming hợp lệ; trình duyệt hỗ trợ HLS/DASH (hoặc qua lib) |
| **Postconditions** | Âm thanh phát/ghi nhận lượt nghe và vị trí dừng |
| **Basic Flow** | (1) User nhấn Play → (2) Player lấy manifest m3u8/mpd → (3) Buffer & phát → (4) Điều khiển Pause/Seek/Next/Prev → (5) Cập nhật PlayHistory |
| **Alternate Flows** | A1: Mạng yếu → adaptive bitrate. A2: Lỗi CDN → thử lại/đổi CDN nếu có. A3: Track geo-locked → thông báo hạn chế. |

### UC-05: Quản lý Playlist (tạo/sửa/xóa, thêm/bớt bài, chia sẻ)

**Brief:** Người dùng tạo playlist cá nhân, chỉnh sửa, đặt public/private, chia sẻ link.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Đăng nhập; track hợp lệ |
| **Postconditions** | Playlist cập nhật & có thể truy cập theo quyền hiển thị |
| **Basic Flow** | (1) Tạo playlist (tiêu đề, ảnh, mô tả) → (2) Thêm/bớt track, sắp xếp → (3) Đặt Visibility → (4) Lưu & chia sẻ link |
| **Alternate Flows** | A1: Thêm track trùng → báo đã tồn tại. A2: Xóa playlist → yêu cầu xác nhận. |

### UC-06: Yêu thích bài hát (Like/Favorite)

**Brief:** Lưu bài hát vào danh sách yêu thích của người dùng.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Đăng nhập; track public |
| **Postconditions** | Bản ghi Like được tạo/xóa (toggle) |
| **Basic Flow** | (1) Nhấn ♥ → (2) Hệ thống lưu Like → (3) Cập nhật UI |
| **Alternate Flows** | A1: Chưa đăng nhập → chuyển tới trang đăng nhập. |

### UC-07: Theo dõi Nghệ sĩ/Album

**Brief:** User theo dõi để nhận cập nhật/đề xuất từ nghệ sĩ/album yêu thích.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Đăng nhập; nghệ sĩ/album tồn tại |
| **Postconditions** | Bản ghi Follow được tạo/xóa; feed gợi ý được cá nhân hóa hơn |
| **Basic Flow** | (1) Nhấn "Follow" → (2) Lưu quan hệ Follow → (3) Cập nhật nút/UI |
| **Alternate Flows** | A1: Đối tượng bị khóa/private → không cho theo dõi. |

### UC-08: Xem Lịch sử & Thống kê (Top 10 gần đây)

**Brief:** Xem lịch sử nghe, danh sách gần đây, thống kê cơ bản.

| Mục | Nội dung |
|-----|----------|
| **Actor** | User |
| **Preconditions** | Đăng nhập; có dữ liệu play history |
| **Postconditions** | Hiển thị danh sách & số liệu tổng hợp |
| **Basic Flow** | (1) Mở trang History → (2) Tải lịch sử theo thời gian → (3) Tính Top 10 gần đây → (4) Cho phép phát lại/xóa mục |
| **Alternate Flows** | A1: Không có dữ liệu → hiển thị gợi ý khám phá. |

### UC-09: Quản trị - Quản lý Artist/Album/Track/Genre

**Brief:** Admin CRUD nội dung, thiết lập phát hành, explicit, liên kết album/genre.

| Mục | Nội dung |
|-----|----------|
| **Actor** | Admin |
| **Preconditions** | Đăng nhập vai trò Admin |
| **Postconditions** | Dữ liệu được tạo/cập nhật/xóa; log audit |
| **Basic Flow** | (1) Vào CMS → (2) Chọn thực thể → (3) Tạo/Sửa fields → (4) Lưu → (5) Xem bản xem trước |
| **Alternate Flows** | A1: Vi phạm ràng buộc (thiếu khóa ngoại) → báo lỗi. A2: Xóa có liên quan → yêu cầu xác nhận & cascade/quarantine. |

### UC-10: Quản trị - Upload demo & cấu hình Streaming URL

**Brief:** Upload file mock (demo) và cấu hình đường dẫn HLS/DASH cho track.

| Mục | Nội dung |
|-----|----------|
| **Actor** | Admin; Audio CDN/Player (external) |
| **Preconditions** | Track tồn tại; có quyền upload & cấu hình CDN |
| **Postconditions** | Track có AudioURL/manifest hợp lệ, sẵn sàng phát |
| **Basic Flow** | (1) Chọn track → (2) Upload file demo hoặc nhập URL m3u8/mpd → (3) Lưu → (4) Kiểm tra phát thử trên Player |
| **Alternate Flows** | A1: Upload thất bại → retry. A2: URL không hợp lệ → báo lỗi & không lưu. |

## 3. Map Use Case ↔ ER Entities

- **UC-01** ↔ User
- **UC-02** ↔ Track, Artist, Album, Playlist, Genre
- **UC-03** ↔ Track (Lyrics, Metadata), gợi ý theo Genre/Artist/Album
- **UC-04** ↔ Track (AudioURL, PublishStatus), PlayHistory
- **UC-05** ↔ Playlist, PlaylistTrack, Track
- **UC-06** ↔ Like, Track
- **UC-07** ↔ Follow, Artist, Album
- **UC-08** ↔ PlayHistory, Track
- **UC-09** ↔ Artist, Album, Track, Genre
- **UC-10** ↔ Track (AudioURL/manifest), liên kết với CDN/Player

## 4. Ghi chú triển khai prototype HLS/DASH

- Tầng Player web: dùng HTML5 audio + Media Source Extensions / hls.js / dash.js (demo).
- Ghi nhận **PlayHistory** tại các mốc: start, 30s, end; lưu `Device`, `PositionSec`.
- Bảo mật: phân quyền **Role** (User/Admin), **Visibility** playlist, kiểm soát **PublishStatus** track.