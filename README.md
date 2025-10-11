# 🎵 Music Streaming Web App

Báo cáo kiểm tra giữa kỳ - Nhập môn Công nghệ Phần mềm

## 📋 Thông tin sinh viên
- **Họ tên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **Ngày nộp:** 11/10/2025

---

## 📖 Giới thiệu

**Music Streaming Web App** là một ứng dụng web nghe nhạc trực tuyến cho phép người dùng tìm kiếm, phát nhạc, tạo playlist, theo dõi nghệ sĩ yêu thích và quản lý lịch sử nghe nhạc. Hệ thống hỗ trợ tiếng Việt có dấu/không dấu và có giao diện quản trị cho Admin.

---

## 🚀 Xem báo cáo

**GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

**Hoặc mở file:** `index.html`

---

## 📁 Cấu trúc thư mục

```
music-streaming-spec/
├── index.html                  # Báo cáo HTML chính
├── README.md                   # File này
│
├── diagrams/                   # Các sơ đồ phân tích thiết kế
│   ├── use-case-diagram.png
│   ├── use-case-specification.md
│   ├── sequence-play-track.png
│   ├── sequence-add-to-playlist.png
│   ├── er-diagram.png
│   └── erd-physical.png
│
├── sql/                        # Database schema
│   └── database_schema_mysql.sql
│
├── prototype/                  # Prototype có thể tương tác
│   ├── index.html             # Trang chủ prototype
│   ├── player.html            # Trang phát nhạc
│   ├── search.html            # Trang tìm kiếm
│   ├── playlist.html          # Trang playlist
│   ├── artist.html            # Trang nghệ sĩ
│   ├── admin.html             # Admin panel
│   └── data/
│       └── seed-data.json     # Dữ liệu mẫu
│
├── test-cases/                 # Test cases chi tiết
│   └── test-cases.md          # 15 test cases
│
├── demo/                       # Video demo
│   └── video-demo.mp4         # Demo 3-5 phút
│
└── screenshots/                # Screenshots các màn hình
    ├── home.png
    ├── player.png
    ├── search.png
    ├── playlist.png
    ├── artist.png
    └── admin.png
```

---

## 🎯 Nội dung báo cáo

### 3.1 Use Case Diagram
Mô tả đầy đủ các actor (User, Admin, Audio CDN/Player) và 10 use case chính:
- **User:** Đăng nhập/Đăng ký, Tìm kiếm, Phát nhạc, Quản lý Playlist, Like/Unlike Track, Follow Artist
- **Admin:** CRUD Artist, Album, Track, Genre

### 3.2 Sequence Diagrams
Hai kịch bản chính:
- **SD-01:** Phát nhạc một bài
  - Luồng: User → WebApp → Player → TrackService → Audio CDN
  - Messages: selectTrack(), getTrackMeta(), initStream(), play(), scrobble()
  
- **SD-02:** Thêm bài vào Playlist
  - Luồng: User → WebApp → PlaylistService → TrackService → DB
  - Messages: addTrack(), checkDuplicate(), updateSortOrder()

### 3.3 ER Diagram (Entity-Relationship)
10 thực thể chính với cardinality và ràng buộc:
1. **User** - Người dùng hệ thống
2. **Artist** - Nghệ sĩ/Ca sĩ
3. **Album** - Album nhạc
4. **Track** - Bài hát
5. **Genre** - Thể loại nhạc
6. **Playlist** - Danh sách phát
7. **PlaylistTrack** - Bảng trung gian Playlist-Track
8. **Like** - Yêu thích bài hát
9. **Follow** - Theo dõi nghệ sĩ
10. **PlayHistory** - Lịch sử nghe nhạc

**Quan hệ chính:**
- User 1-N Playlist
- Artist 1-N Album
- Album 1-N Track
- Playlist N-N Track (qua PlaylistTrack)
- User N-N Track (Like)
- User N-N Artist (Follow)
- User 1-N PlayHistory

### 3.4 ERD (Logical/Physical Database)
Chi tiết 10 bảng với:
- Khóa chính (Primary Key)
- Khóa ngoại (Foreign Key) với ON DELETE CASCADE
- Kiểu dữ liệu (MySQL 8+)
- Ràng buộc: UNIQUE, CHECK, NOT NULL
- Index cho tối ưu tìm kiếm
- Composite Key cho bảng trung gian

File SQL: `sql/database_schema_mysql.sql`

### 3.5 Prototype UI (5 màn hình + Bonus)

**5 màn chính:**
1. **Home/Discover** - Trang chủ với đề xuất bài hát, album, playlist
2. **Player Mini + Track Detail** - Thanh player cố định dưới cùng với controls đầy đủ
3. **Search** - Tìm kiếm hỗ trợ có dấu/không dấu tiếng Việt
4. **Playlist Detail** - Quản lý playlist với drag-drop sắp xếp
5. **Artist/Album Page** - Trang nghệ sĩ với danh sách bài hát và album

**Bonus:**
6. **Admin Panel** - Giao diện CRUD nghệ sĩ/album/bài hát/thể loại

### 3.6 Test Cases & Business Rules

**Quy tắc nghiệp vụ:**
1. Một bài hát chỉ xuất hiện 1 lần trong playlist (UNIQUE constraint)
2. Lịch sử nghe chỉ ghi khi play ≥ 30 giây hoặc next sau ≥ 30s
3. Like/Unlike toggle: click lần 2 = xóa like
4. Playlist private chỉ owner nhìn thấy
5. Admin xóa Artist → CASCADE xóa Album + Track

**Test Cases:** 15 test cases được phân loại theo:
- Playlist Management (TC-01, TC-02)
- Like/Favorite (TC-03, TC-04)
- Search (TC-05, TC-06, TC-07)
- Play History (TC-08, TC-09, TC-10)
- Permissions (TC-11, TC-12)
- Audio Player (TC-13, TC-14, TC-15)

Chi tiết: `test-cases/test-cases.md`

### 3.7 Demo Video
Video demo 3-5 phút minh họa:
- [0:00-0:30] Giới thiệu hệ thống và layout
- [0:30-1:00] Phát nhạc: play/pause/seek/volume
- [1:00-1:30] Tìm kiếm không dấu + phát từ kết quả
- [1:30-2:00] Playlist: thêm bài, drag-drop sắp xếp
- [2:00-2:30] Trang Artist: Follow, Like bài hát
- [2:30-3:00] Admin Panel: CRUD bài hát

File: `demo/video-demo.mp4`

### 3.8 Báo cáo HTML trên GitHub
Trang `index.html` tổng hợp đầy đủ các diagram, prototype, test cases và video demo, được deploy lên GitHub Pages.

---

## 🎮 Hướng dẫn chạy Prototype

### Cách 1: Mở trực tiếp file HTML
```bash
# Mở file prototype/index.html bằng trình duyệt
# Hoặc double-click vào file
```

### Cách 2: Chạy local server (Khuyến nghị)
```bash
# Sử dụng Python 3
cd prototype
python -m http.server 8000

# Hoặc Python 2
python -m SimpleHTTPServer 8000

# Hoặc sử dụng Live Server extension trong VS Code
```

Sau đó truy cập: `http://localhost:8000`

**Lưu ý:** 
- Prototype sử dụng mock data từ file JSON
- Audio files là placeholder (URL demo)
- Tất cả tính năng đều hoạt động với dữ liệu mẫu

---

## 🎵 Dữ liệu mẫu (Seed Data)

### Thống kê
- **10 nghệ sĩ** Việt Nam nổi tiếng
- **20 bài hát** đa thể loại
- **5 album** từ các nghệ sĩ khác nhau
- **5 playlist** mẫu
- **3 user** test (1 admin, 2 user)

### Danh sách nghệ sĩ
Sơn Tùng M-TP, Hòa Minzy, Đen Vâu, Mỹ Tâm, HIEUTHUHAI, Chi Pu, Bích Phương, Erik, Amee, Vũ.

### Một số bài hát
Lạc Trôi, Nơi Này Có Anh, Rời Bỏ, Mơ, Đưa Nhau Đi Trốn, Chúng Ta Của Hiện Tại, 3107, Ngủ Một Mình, Anh Ơi Ở Lại, Bùa Yêu...

### Albums
- m-tp M-TP (Sơn Tùng M-TP)
- Rời Bỏ (Hòa Minzy)  
- Mơ (Đen Vâu)
- Tâm 9 (Mỹ Tâm)
- Ai Cũng Phải Bắt Đầu Từ Đâu Đó (HIEUTHUHAI)

Chi tiết: `prototype/data/seed-data.json`

---

## ✨ Tính năng đã implement

### 🎵 Audio Player
- ✅ Play/Pause/Stop
- ✅ Seek bar (tua bài hát)
- ✅ Volume control (điều chỉnh âm lượng)
- ✅ Next/Previous track
- ✅ Shuffle mode (phát ngẫu nhiên)
- ✅ Repeat mode (lặp lại: off/one/all)
- ✅ Display current time/duration
- ✅ Progress bar animation

### 🔍 Search & Discovery
- ✅ Tìm kiếm có dấu + không dấu tiếng Việt
- ✅ Tìm theo: Track, Artist, Album
- ✅ Filter theo Genre
- ✅ Sort by: Mới nhất, Phổ biến, A-Z

### 💖 User Interactions
- ✅ Like/Unlike tracks
- ✅ Follow/Unfollow artist
- ✅ Create/Edit/Delete playlist
- ✅ Add/Remove track from playlist
- ✅ Drag-drop reorder playlist

### 📊 History & Analytics
- ✅ Play history logging (quy tắc 30 giây)
- ✅ Recently played tracks
- ✅ Most played tracks
- ✅ Listening statistics

### 👨‍💼 Admin Features
- ✅ CRUD Artist (Create, Read, Update, Delete)
- ✅ CRUD Album
- ✅ CRUD Track
- ✅ CRUD Genre
- ✅ User management

---

## 🔧 Công nghệ sử dụng

### Frontend
- **HTML5** - Structure
- **Tailwind CSS** - Styling framework
- **Vanilla JavaScript** - Logic & interactions
- **HTML5 Audio API** - Audio playback
- **HTML5 Drag & Drop API** - Playlist reordering

### Data & Storage
- **JSON** - Mock database
- **LocalStorage** - Client-side caching (trong prototype)

### Database (Design only)
- **MySQL 8+** - Relational database
- **SQL Schema** - Physical database design

### Tools & Platforms
- **GitHub Pages** - Deployment
- **VS Code** - Development
- **Draw.io / Lucidchart** - Diagrams

---

## 📊 Chi tiết 10 thực thể (ERD)

### 1. User
```
- UserID (PK, INT, AUTO_INCREMENT)
- Email (VARCHAR(255), UNIQUE, NOT NULL)
- Password (VARCHAR(255), NOT NULL)
- DisplayName (VARCHAR(100))
- Avatar (VARCHAR(500))
- CreatedAt (DATETIME)
- Role (ENUM: 'user', 'admin')
```

### 2. Artist
```
- ArtistID (PK, INT, AUTO_INCREMENT)
- Name (VARCHAR(200), NOT NULL)
- Bio (TEXT)
- Avatar (VARCHAR(500))
- Country (VARCHAR(100))
- CreatedAt (DATETIME)
```

### 3. Album
```
- AlbumID (PK, INT, AUTO_INCREMENT)
- Title (VARCHAR(200), NOT NULL)
- ArtistID (FK -> Artist.ArtistID)
- CoverImage (VARCHAR(500))
- ReleaseDate (DATE)
- CreatedAt (DATETIME)
```

### 4. Track
```
- TrackID (PK, INT, AUTO_INCREMENT)
- Title (VARCHAR(200), NOT NULL, INDEX)
- AlbumID (FK -> Album.AlbumID)
- ArtistID (FK -> Artist.ArtistID)
- GenreID (FK -> Genre.GenreID)
- Duration (INT, NOT NULL, CHECK > 0)
- AudioURL (VARCHAR(500))
- CoverImage (VARCHAR(500))
- ReleaseDate (DATE)
- PlayCount (INT, DEFAULT 0)
- CreatedAt (DATETIME)
```

### 5. Genre
```
- GenreID (PK, INT, AUTO_INCREMENT)
- Name (VARCHAR(100), NOT NULL, UNIQUE)
- Description (TEXT)
```

### 6. Playlist
```
- PlaylistID (PK, INT, AUTO_INCREMENT)
- UserID (FK -> User.UserID)
- Title (VARCHAR(200), NOT NULL)
- Description (TEXT)
- CoverImage (VARCHAR(500))
- Visibility (ENUM: 'public', 'private')
- CreatedAt (DATETIME)
- UpdatedAt (DATETIME)
```

### 7. PlaylistTrack (Bảng trung gian)
```
- PlaylistID (PK, FK -> Playlist.PlaylistID)
- TrackID (PK, FK -> Track.TrackID)
- SortOrder (INT, NOT NULL)
- AddedAt (DATETIME)
- UNIQUE(PlaylistID, TrackID)
```

### 8. Like
```
- UserID (PK, FK -> User.UserID)
- TrackID (PK, FK -> Track.TrackID)
- LikedAt (DATETIME)
```

### 9. Follow
```
- UserID (PK, FK -> User.UserID)
- ArtistID (PK, FK -> Artist.ArtistID)
- FollowedAt (DATETIME)
```

### 10. PlayHistory
```
- HistoryID (PK, INT, AUTO_INCREMENT)
- UserID (FK -> User.UserID)
- TrackID (FK -> Track.TrackID)
- PlayedAt (DATETIME)
- Duration (INT) -- Số giây đã nghe
- CompletedPlay (BOOLEAN) -- Có nghe hết không
```

---

## 📝 Quy tắc nghiệp vụ chi tiết

### 1. Unique Track trong Playlist
- Mỗi bài hát chỉ xuất hiện **MỘT LẦN** trong một playlist
- Constraint: `UNIQUE(PlaylistID, TrackID)`
- Khi thêm bài trùng → Hiển thị lỗi "Bài đã có trong playlist"

### 2. Scrobble Rule (30 giây)
- Lịch sử nghe chỉ được ghi khi:
  - Nghe ≥ 30 giây liên tục, HOẶC
  - Nhấn Next sau khi nghe ≥ 30 giây
- Nếu < 30 giây → KHÔNG ghi vào PlayHistory

### 3. Like/Unlike Toggle
- Click Like lần 1: Thêm vào bảng Like
- Click Like lần 2 (Unlike): Xóa khỏi bảng Like
- Icon: ❤️ (liked) / 🤍 (not liked)

### 4. Playlist Visibility
- **Public:** Ai cũng xem được
- **Private:** Chỉ owner xem được
- Default: Public

### 5. Cascade Delete
- Xóa Artist → Tự động xóa:
  - Tất cả Album của Artist đó
  - Tất cả Track thuộc Album đó
- Xóa Album → Tự động xóa:
  - Tất cả Track trong Album
- Xóa Playlist → Tự động xóa:
  - Tất cả PlaylistTrack liên quan
- Xóa User → Tự động xóa:
  - Playlist của user
  - Like, Follow, PlayHistory

---

## 🧪 Test Cases (Tóm tắt)

| ID | Tên Test Case | Mục đích | Priority |
|---|---|---|---|
| TC-01 | Thêm bài trùng vào playlist | Kiểm tra UNIQUE constraint | 🔴 High |
| TC-02 | Sắp xếp playlist drag-drop | Kiểm tra UI + SortOrder | 🔴 High |
| TC-03 | Like track lần đầu | Thêm Like | 🔴 High |
| TC-04 | Unlike track (like lần 2) | Toggle logic | 🔴 High |
| TC-05 | Search không dấu | Tìm kiếm tiếng Việt | 🟡 Medium |
| TC-08 | Play < 30s không ghi lịch sử | Quy tắc scrobble | 🔴 High |
| TC-09 | Play ≥ 30s ghi lịch sử | Quy tắc scrobble | 🔴 High |
| TC-12 | Admin xóa Artist có Album | FK CASCADE | 🔴 High |

Chi tiết 15 test cases: `test-cases/test-cases.md`

---

## 🎬 Video Demo

**File:** `demo/video-demo.mp4`  
**Thời lượng:** 3-5 phút  

**Timeline:**
- [0:00-0:30] Giới thiệu hệ thống, layout tổng quan
- [0:30-1:00] Demo audio player: play/pause/seek/volume/next/previous
- [1:00-1:30] Tìm kiếm không dấu tiếng Việt + phát từ kết quả
- [1:30-2:00] Quản lý playlist: thêm bài, drag-drop sắp xếp
- [2:00-2:30] Trang Artist/Album: Follow nghệ sĩ, Like bài hát
- [2:30-3:00] Admin panel: CRUD bài hát, album, nghệ sĩ

---

## 🔗 Links quan trọng

- **GitHub Repository:** [https://github.com/Harihuynh2007/music-streaming-spec](https://github.com/Harihuynh2007/music-streaming-spec)
- **GitHub Pages (Live Demo):** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)
- **Prototype:** [./prototype/index.html](./prototype/index.html)
- **Video Demo:** [./demo/video-demo.mp4](./demo/video-demo.mp4)
- **Use Case Spec:** [./diagrams/use-case-specification.md](./diagrams/use-case-specification.md)
- **Test Cases:** [./test-cases/test-cases.md](./test-cases/test-cases.md)
- **SQL Schema:** [./sql/database_schema_mysql.sql](./sql/database_schema_mysql.sql)

---

## 📞 Liên hệ

- **Sinh viên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **Email:** n18dccn053@student.ptithcm.edu.vn
- **GitHub:** [@Harihuynh2007](https://github.com/Harihuynh2007)

---

## 📄 License

Đây là project học tập cho môn Nhập môn Công nghệ Phần mềm - PTIT HCM.

---

**🎓 Học kỳ:** 2024-2025  
**🏫 Trường:** Học viện Công nghệ Bưu chính Viễn thông - Phân hiệu TP.HCM  
**📚 Môn học:** Nhập môn Công nghệ Phần mềm