# 🎵 Music Streaming Web App

Báo cáo kiểm tra giữa kỳ - Nhập môn Công nghệ Phần mềm

## 📋 Thông tin sinh viên
- **Họ tên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **Ngày nộp:** 11/10/2025

---

## 📖 Giới thiệu hệ thống

**Music Streaming Web App** là ứng dụng web nghe nhạc trực tuyến cho phép người dùng tìm kiếm, phát nhạc, tạo playlist, theo dõi nghệ sĩ và quản lý lịch sử nghe nhạc. Hệ thống hỗ trợ tiếng Việt có dấu/không dấu và có giao diện quản trị cho Admin.

---

## 🚀 Xem báo cáo

**GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

**Hoặc mở file:** `index.html`

---

## 🔧 Công nghệ sử dụng

### Frontend
- **HTML5** - Cấu trúc trang web
- **Tailwind CSS 3.x** - Framework CSS utility-first
- **Vanilla JavaScript (ES6+)** - Xử lý logic và tương tác
- **HTML5 Audio API** - Phát nhạc và điều khiển playback
- **HTML5 Drag & Drop API** - Sắp xếp playlist bằng kéo thả

### Database Design
- **MySQL 8+** - Hệ quản trị CSDL quan hệ
- **10 bảng** với đầy đủ khóa chính/ngoại, ràng buộc, và index

### Data Management
- **JSON** - Lưu trữ dữ liệu mẫu (mock database)
- **LocalStorage** - Cache dữ liệu phía client (trong prototype)

---

## 📊 Thiết kế cơ sở dữ liệu (ERD)

### 10 thực thể chính

#### 1. **User** - Người dùng hệ thống
```sql
UserID (PK, INT, AUTO_INCREMENT)
Email (VARCHAR(255), UNIQUE, NOT NULL)
Password (VARCHAR(255), NOT NULL)
DisplayName (VARCHAR(100))
Avatar (VARCHAR(500))
CreatedAt (DATETIME, DEFAULT NOW())
Role (ENUM('user', 'admin'), DEFAULT 'user')
```

#### 2. **Artist** - Nghệ sĩ/Ca sĩ
```sql
ArtistID (PK, INT, AUTO_INCREMENT)
Name (VARCHAR(200), NOT NULL, INDEX)
Bio (TEXT)
Avatar (VARCHAR(500))
Country (VARCHAR(100))
CreatedAt (DATETIME)
```

#### 3. **Album** - Album nhạc
```sql
AlbumID (PK, INT, AUTO_INCREMENT)
Title (VARCHAR(200), NOT NULL)
ArtistID (FK → Artist.ArtistID, ON DELETE CASCADE)
CoverImage (VARCHAR(500))
ReleaseDate (DATE)
CreatedAt (DATETIME)
```

#### 4. **Track** - Bài hát
```sql
TrackID (PK, INT, AUTO_INCREMENT)
Title (VARCHAR(200), NOT NULL, INDEX)
AlbumID (FK → Album.AlbumID, ON DELETE CASCADE)
ArtistID (FK → Artist.ArtistID, ON DELETE CASCADE)
GenreID (FK → Genre.GenreID, ON DELETE SET NULL)
Duration (INT, NOT NULL, CHECK > 0)
AudioURL (VARCHAR(500))
CoverImage (VARCHAR(500))
ReleaseDate (DATE)
PlayCount (INT, DEFAULT 0)
CreatedAt (DATETIME)
```

#### 5. **Genre** - Thể loại nhạc
```sql
GenreID (PK, INT, AUTO_INCREMENT)
Name (VARCHAR(100), NOT NULL, UNIQUE)
Description (TEXT)
```

#### 6. **Playlist** - Danh sách phát
```sql
PlaylistID (PK, INT, AUTO_INCREMENT)
UserID (FK → User.UserID, ON DELETE CASCADE)
Title (VARCHAR(200), NOT NULL)
Description (TEXT)
CoverImage (VARCHAR(500))
Visibility (ENUM('public', 'private'), DEFAULT 'public')
CreatedAt (DATETIME)
UpdatedAt (DATETIME)
```

#### 7. **PlaylistTrack** - Bảng trung gian Playlist-Track
```sql
PlaylistID (PK, FK → Playlist.PlaylistID, ON DELETE CASCADE)
TrackID (PK, FK → Track.TrackID, ON DELETE CASCADE)
SortOrder (INT, NOT NULL)
AddedAt (DATETIME)
UNIQUE KEY (PlaylistID, TrackID)
```

#### 8. **Like** - Yêu thích bài hát
```sql
UserID (PK, FK → User.UserID, ON DELETE CASCADE)
TrackID (PK, FK → Track.TrackID, ON DELETE CASCADE)
LikedAt (DATETIME)
```

#### 9. **Follow** - Theo dõi nghệ sĩ
```sql
UserID (PK, FK → User.UserID, ON DELETE CASCADE)
ArtistID (PK, FK → Artist.ArtistID, ON DELETE CASCADE)
FollowedAt (DATETIME)
```

#### 10. **PlayHistory** - Lịch sử nghe nhạc
```sql
HistoryID (PK, INT, AUTO_INCREMENT)
UserID (FK → User.UserID, ON DELETE CASCADE)
TrackID (FK → Track.TrackID, ON DELETE CASCADE)
PlayedAt (DATETIME)
Duration (INT) -- Số giây đã nghe
CompletedPlay (BOOLEAN) -- Có nghe hết hay không
```

### Quan hệ giữa các thực thể

```
User 1──N Playlist
User 1──N PlayHistory
User N──N Track (Like)
User N──N Artist (Follow)

Artist 1──N Album
Artist 1──N Track

Album 1──N Track

Genre 1──N Track

Playlist N──N Track (qua PlaylistTrack)
```

### Ràng buộc và chỉ mục quan trọng

**Primary Keys:**
- Tất cả bảng có khóa chính (PK)
- Bảng trung gian dùng Composite Key

**Foreign Keys:**
- `ON DELETE CASCADE` cho: PlaylistTrack, Like, Follow, PlayHistory, Album, Track
- `ON DELETE SET NULL` cho: Track.GenreID

**Unique Constraints:**
- `User.Email` - Email không trùng lặp
- `Genre.Name` - Tên thể loại duy nhất
- `(PlaylistID, TrackID)` - Một bài chỉ xuất hiện 1 lần trong playlist

**Check Constraints:**
- `Track.Duration > 0` - Thời lượng bài hát > 0 giây

**Indexes:**
- `Track.Title` - Tối ưu tìm kiếm bài hát
- `Artist.Name` - Tối ưu tìm kiếm nghệ sĩ

---

## 📜 Quy tắc nghiệp vụ (Business Rules)

### 1. **Unique Track trong Playlist**
- **Quy tắc:** Một bài hát chỉ được thêm **MỘT LẦN** vào mỗi playlist
- **Implementation:** `UNIQUE KEY (PlaylistID, TrackID)`
- **Xử lý:** Khi thêm bài trùng → Hiển thị lỗi "Bài đã có trong playlist"

### 2. **Scrobble Rule (30 giây)**
- **Quy tắc:** Lịch sử nghe chỉ được ghi khi:
  - Nghe ≥ 30 giây liên tục, HOẶC
  - Nhấn Next/Previous sau khi nghe ≥ 30 giây
- **Implementation:** JavaScript timer kiểm tra `currentTime` của Audio API
- **Lưu trữ:** Ghi vào bảng `PlayHistory` với `Duration` và `CompletedPlay`

### 3. **Like/Unlike Toggle**
- **Quy tắc:**
  - Click Like lần 1: INSERT vào bảng `Like`
  - Click Like lần 2 (Unlike): DELETE khỏi bảng `Like`
- **Implementation:** Check exist trong DB trước khi INSERT/DELETE
- **UI:** Icon ❤️ (liked) / 🤍 (not liked)

### 4. **Playlist Visibility**
- **Quy tắc:**
  - `public`: Tất cả user xem được
  - `private`: Chỉ owner (UserID = creator) xem được
- **Implementation:** `ENUM('public', 'private')`
- **Query:** `WHERE Visibility = 'public' OR UserID = :currentUserId`

### 5. **Cascade Delete**
- **Artist deleted →** Tự động xóa:
  - Tất cả Album của Artist (`Album.ArtistID`)
  - Tất cả Track thuộc Album đó (`Track.AlbumID`)
- **Album deleted →** Tự động xóa:
  - Tất cả Track trong Album
- **Playlist deleted →** Tự động xóa:
  - Tất cả record trong PlaylistTrack
- **User deleted →** Tự động xóa:
  - Playlist, Like, Follow, PlayHistory của user
- **Implementation:** `ON DELETE CASCADE` trong Foreign Key

### 6. **SortOrder trong Playlist**
- **Quy tắc:** Bài hát trong playlist có thứ tự (`SortOrder`)
- **Drag-drop:** Cập nhật `SortOrder` của tất cả track bị ảnh hưởng
- **Insert mới:** `SortOrder = MAX(SortOrder) + 1`

---

## 🧪 Test Cases quan trọng

| ID | Test Case | Business Rule | Expected Result |
|---|---|---|---|
| TC-01 | Thêm bài trùng vào playlist | Rule #1 | Error: "Bài đã có trong playlist" |
| TC-02 | Drag-drop sắp xếp playlist | Rule #6 | SortOrder cập nhật đúng |
| TC-03 | Like track lần đầu | Rule #3 | INSERT vào Like, icon đổi màu đỏ |
| TC-04 | Unlike track (click lần 2) | Rule #3 | DELETE từ Like, icon outline |
| TC-05 | Search không dấu tiếng Việt | N/A | Tìm đúng "Lac Troi" → "Lạc Trôi" |
| TC-08 | Play < 30s, next sang bài khác | Rule #2 | Không ghi PlayHistory |
| TC-09 | Play ≥ 30s, next sang bài khác | Rule #2 | Ghi vào PlayHistory |
| TC-11 | User xem playlist private của người khác | Rule #4 | Access denied / 404 |
| TC-12 | Admin xóa Artist có Album | Rule #5 | CASCADE xóa Album + Track |

Chi tiết: `test-cases/test-cases.md`

---

## 🎮 Hướng dẫn chạy Prototype

### Cách 1: Mở trực tiếp
```bash
# Mở file prototype/index.html bằng browser
```

### Cách 2: Local server (Khuyến nghị)
```bash
cd prototype
python -m http.server 8000
# Truy cập: http://localhost:8000
```

**Lưu ý:** 
- Prototype dùng mock data từ JSON
- Tất cả tính năng hoạt động với dữ liệu mẫu

---

## 📁 Cấu trúc thư mục

```
music-streaming-spec/
├── index.html                      # Báo cáo HTML
├── README.md                       
├── diagrams/                       # Sơ đồ phân tích
│   ├── use-case-diagram.png
│   ├── use-case-specification.md
│   ├── sequence-play-track.png
│   ├── sequence-add-to-playlist.png
│   ├── er-diagram.png
│   └── erd-physical.png
├── sql/                            
│   └── database_schema_mysql.sql   # Schema MySQL
├── prototype/                      # Prototype HTML
│   ├── index.html
│   └── data/seed-data.json
├── test-cases/                     
│   └── test-cases.md               # 15 test cases
├── demo/                           
│   └── video-demo.mp4
└── screenshots/                    # Screenshots UI
```

---

## 🎵 Dữ liệu mẫu

- **10 nghệ sĩ:** Sơn Tùng M-TP, Hòa Minzy, Đen Vâu, Mỹ Tâm, HIEUTHUHAI, Chi Pu, Bích Phương, Erik, Amee, Vũ
- **20 bài hát:** Lạc Trôi, Nơi Này Có Anh, Rời Bỏ, Mơ, Đưa Nhau Đi Trốn...
- **5 album:** m-tp M-TP, Rời Bỏ, Mơ, Tâm 9, Ai Cũng Phải Bắt Đầu Từ Đâu Đó
- **5 playlist:** Top Hits Việt 2024, Chill Vibes, My Favorites...

Chi tiết: `prototype/data/seed-data.json`

---

## 🔗 Links

- **GitHub Repo:** [github.com/Harihuynh2007/music-streaming-spec](https://github.com/Harihuynh2007/music-streaming-spec)
- **GitHub Pages:** [harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)
- **SQL Schema:** [./sql/database_schema_mysql.sql](./sql/database_schema_mysql.sql)

---

## 📞 Liên hệ

- **Sinh viên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **GitHub:** [@Harihuynh2007](https://github.com/Harihuynh2007)