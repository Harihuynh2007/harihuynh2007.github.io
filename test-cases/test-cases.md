# Test Cases - Music Streaming Web App

## 1. Playlist Management

### TC-01: Thêm bài hát trùng vào playlist
- **Mô tả**: Kiểm tra ràng buộc UNIQUE khi thêm bài đã tồn tại
- **Precondition**: Playlist có sẵn TrackID = 1
- **Steps**:
  1. Mở playlist detail
  2. Click "Add track" và chọn TrackID = 1
  3. Submit
- **Expected**: Hiển thị lỗi "Bài hát đã có trong playlist"
- **Priority**: High

### TC-02: Sắp xếp playlist bằng drag-drop
- **Mô tả**: Kiểm tra UI drag-drop và cập nhật SortOrder
- **Precondition**: Playlist có ≥ 3 bài hát
- **Steps**:
  1. Mở playlist detail
  2. Kéo bài hát từ vị trí 3 lên vị trí 1
  3. Kiểm tra SortOrder trong DB
- **Expected**: 
  - UI cập nhật ngay lập tức
  - SortOrder: track cũ vị trí 1,2 dịch xuống
- **Priority**: High

---

## 2. Like/Favorite Feature

### TC-03: Like bài hát lần đầu
- **Mô tả**: Kiểm tra thêm mới Like
- **Precondition**: User chưa like TrackID = 5
- **Steps**:
  1. Vào trang Track detail
  2. Click nút "Like" (trái tim)
- **Expected**: 
  - Icon chuyển sang đỏ/filled
  - Ghi record vào bảng Like
- **Priority**: High

### TC-04: Unlike bài hát (like lần 2)
- **Mô tả**: Kiểm tra toggle logic
- **Precondition**: User đã like TrackID = 5
- **Steps**:
  1. Click nút "Like" lần 2
- **Expected**: 
  - Icon chuyển về outline
  - Xóa record khỏi bảng Like
- **Priority**: High

---

## 3. Search Functionality

### TC-05: Tìm kiếm không dấu tiếng Việt
- **Mô tả**: Hỗ trợ tìm kiếm không dấu
- **Steps**:
  1. Nhập "son tung" vào search box
  2. Enter
- **Expected**: Trả về "Sơn Tùng M-TP" và các bài hát liên quan
- **Priority**: Medium

### TC-06: Tìm kiếm có dấu chính xác
- **Mô tả**: Tìm kiếm với dấu tiếng Việt
- **Steps**:
  1. Nhập "Sơn Tùng" vào search box
- **Expected**: Trả về kết quả chính xác
- **Priority**: Medium

### TC-07: Tìm kiếm không có kết quả
- **Mô tả**: Xử lý trường hợp không tìm thấy
- **Steps**:
  1. Nhập "abcxyz123" vào search box
- **Expected**: Hiển thị "Không tìm thấy kết quả"
- **Priority**: Low

---

## 4. Play History (Scrobble)

### TC-08: Ghi lịch sử khi nghe < 30 giây
- **Mô tả**: Kiểm tra quy tắc scrobble
- **Precondition**: User bật bài hát mới
- **Steps**:
  1. Play bài hát
  2. Nghe 20 giây
  3. Stop hoặc chuyển trang
- **Expected**: KHÔNG ghi vào bảng PlayHistory
- **Priority**: High

### TC-09: Ghi lịch sử khi nghe ≥ 30 giây
- **Mô tả**: Kiểm tra quy tắc scrobble hợp lệ
- **Steps**:
  1. Play bài hát
  2. Nghe 35 giây
  3. Stop
- **Expected**: 
  - Ghi vào PlayHistory
  - PositionSec = 35
  - PlayedAt = timestamp hiện tại
- **Priority**: High

### TC-10: Ghi lịch sử khi nhấn Next sau 30s
- **Mô tả**: Edge case: next track
- **Steps**:
  1. Play bài hát A
  2. Nghe 31 giây
  3. Nhấn nút "Next"
- **Expected**: Ghi lịch sử cho bài A trước khi chuyển sang bài B
- **Priority**: High

---

## 5. Visibility & Permissions

### TC-11: Tạo playlist private
- **Mô tả**: Kiểm tra phân quyền playlist
- **Steps**:
  1. Tạo playlist mới
  2. Chọn visibility = "private"
  3. Save
- **Expected**: 
  - Chỉ owner nhìn thấy trong My Playlists
  - User khác không tìm thấy qua Search
- **Priority**: Medium

### TC-12: Admin xóa Artist có Album
- **Mô tả**: Kiểm tra FK CASCADE
- **Precondition**: Artist có ≥ 1 Album, Album có ≥ 1 Track
- **Steps**:
  1. Login với role Admin
  2. Vào Artist management
  3. Delete Artist
- **Expected**: 
  - Cascade xóa tất cả Album liên quan
  - Cascade xóa tất cả Track của Album đó
- **Priority**: High
- **⚠️ Warning**: Cần confirm dialog trước khi xóa

---

## 6. Audio Player Controls

### TC-13: Play/Pause toggle
- **Mô tả**: Kiểm tra nút play/pause
- **Steps**:
  1. Click Play
  2. Click Pause
  3. Click Play lại
- **Expected**: 
  - Audio phát/dừng đúng
  - Icon button thay đổi
- **Priority**: High

### TC-14: Seek bar (tua bài)
- **Mô tả**: Kiểm tra thanh seek
- **Steps**:
  1. Play bài hát
  2. Kéo seek bar đến 50%
- **Expected**: Audio nhảy đến đúng vị trí 50% duration
- **Priority**: High

### TC-15: Shuffle mode
- **Mô tả**: Kiểm tra phát ngẫu nhiên
- **Steps**:
  1. Bật shuffle
  2. Nhấn Next 5 lần
- **Expected**: Thứ tự bài hát không theo playlist, ngẫu nhiên
- **Priority**: Medium

---

## Summary
- **Total Test Cases**: 15
- **High Priority**: 10
- **Medium Priority**: 4
- **Low Priority**: 1

## Test Coverage
- ✅ Playlist Management (2 TCs)
- ✅ Like/Favorite (2 TCs)
- ✅ Search (3 TCs)
- ✅ Play History (3 TCs)
- ✅ Permissions (2 TCs)
- ✅ Audio Player (3 TCs)