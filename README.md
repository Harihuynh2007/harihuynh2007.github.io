# 🎵 Music Streaming Web App

Báo cáo kiểm tra giữa kỳ - Nhập môn Công nghệ Phần mềm

## 📋 Thông tin sinh viên
- **Họ tên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **Ngày nộp:** 11/10/2025

---

## 📖 Giới thiệu

**Music Streaming Web App** là ứng dụng web nghe nhạc trực tuyến cho phép người dùng tìm kiếm, phát nhạc, tạo playlist, theo dõi nghệ sĩ và quản lý lịch sử nghe nhạc. Hệ thống hỗ trợ tiếng Việt có dấu/không dấu và có giao diện quản trị cho Admin.

---

## 🚀 Xem báo cáo

**GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

**Hoặc mở file:** `index.html`

---

## 📁 Cấu trúc thư mục

```
music-streaming-spec/
├── index.html                      # Báo cáo HTML chính
├── README.md                       
├── diagrams/                       # Các sơ đồ phân tích
│   ├── use-case-diagram.png
│   ├── use-case-specification.md
│   ├── sequence-play-track.png
│   ├── sequence-add-to-playlist.png
│   ├── er-diagram.png
│   └── erd-physical.png
├── sql/                            
│   └── database_schema_mysql.sql   # SQL Schema
├── prototype/                      # Prototype HTML
│   ├── index.html
│   └── data/seed-data.json
├── test-cases/                     
│   └── test-cases.md               # 15 test cases
├── demo/                           
│   └── video-demo.mp4              # Video demo
└── screenshots/                    # Screenshots UI
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

**Actors:**
- **User** - Người dùng
- **Admin** - Quản trị viên  
- **Audio CDN/Player** - Hệ thống phát nhạc

**Use Cases:**
- UC-01: Đăng nhập/Đăng ký
- UC-02: Tìm kiếm Track/Artist
- UC-03: Phát nhạc
- UC-04: Quản lý Playlist
- UC-05: Like/Unlike Track
- UC-06: Follow Artist
- UC-07: CRUD Artist (Admin)
- UC-08: CRUD Album (Admin)
- UC-09: CRUD Track (Admin)
- UC-10: CRUD Genre (Admin)

📄 File: `diagrams/use-case-diagram.png` và `diagrams/use-case-specification.md`

---

### 3.2 Sequence Diagrams

**SD-01: Phát nhạc một bài**
- **Luồng:** User → WebApp → Player → TrackService → Audio CDN
- **Messages:** selectTrack(), getTrackMeta(), initStream(), play(), scrobble()

**SD-02: Thêm bài vào Playlist**
- **Luồng:** User → WebApp → PlaylistService → TrackService → DB
- **Messages:** addTrack(), checkDuplicate(), updateSortOrder()

📄 Files: `diagrams/sequence-play-track.png`, `diagrams/sequence-add-to-playlist.png`

---

### 3.3 ER Diagram (Entity-Relationship)

**10 thực thể chính:**
1. User - Người dùng hệ thống
2. Artist - Nghệ sĩ/Ca sĩ
3. Album - Album nhạc
4. Track - Bài hát
5. Genre - Thể loại nhạc
6. Playlist - Danh sách phát
7. PlaylistTrack - Bảng trung gian Playlist-Track
8. Like - Yêu thích bài hát
9. Follow - Theo dõi nghệ sĩ
10. PlayHistory - Lịch sử nghe nhạc

**Quan hệ chính:**
- User 1-N Playlist
- Artist 1-N Album
- Album 1-N Track
- Playlist N-N Track (qua PlaylistTrack)
- User N-N Track (Like)
- User N-N Artist (Follow)
- User 1-N PlayHistory

📄 File: `diagrams/er-diagram.png`

---

### 3.4 ERD (Logical/Physical Database)

Chi tiết 10 bảng với kiểu dữ liệu MySQL 8+, khóa chính/ngoại, ràng buộc, và index.

#### 1. **User**
```sql
UserID (PK, INT, AUTO_INCREMENT)
Email (VARCHAR(255), UNIQUE, NOT NULL)
Password (VARCHAR(255), NOT NULL)
DisplayName (VARCHAR(100))
Avatar (VARCHAR(500))
CreatedAt (DATETIME, DEFAULT NOW())
Role (ENUM('user', 'admin'), DEFAULT 'user')
```

#### 2. **Artist**
```sql
ArtistID (PK, INT, AUTO_INCREMENT)
Name (VARCHAR(200), NOT NULL, INDEX)
Bio (TEXT)
Avatar (VARCHAR(500))
Country (VARCHAR(100))
CreatedAt (DATETIME)
```

#### 3. **Album**
```sql
AlbumID (PK, INT, AUTO_INCREMENT)
Title (VARCHAR(200), NOT NULL)
ArtistID (FK → Artist.ArtistID, ON DELETE CASCADE)
CoverImage (VARCHAR(500))
ReleaseDate (DATE)
CreatedAt (DATETIME)
```

#### 4. **Track**
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

#### 5. **Genre**
```sql
GenreID (PK, INT, AUTO_INCREMENT)
Name (VARCHAR(100), NOT NULL, UNIQUE)
Description (TEXT)
```

#### 6. **Playlist**
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

#### 7. **PlaylistTrack** (Bảng trung gian)
```sql
PlaylistID (PK, FK → Playlist.PlaylistID, ON DELETE CASCADE)
TrackID (PK, FK → Track.TrackID, ON DELETE CASCADE)
SortOrder (INT, NOT NULL)
AddedAt (DATETIME)
UNIQUE KEY (PlaylistID, TrackID)
```

#### 8. **Like**
```sql
UserID (PK, FK → User.UserID, ON DELETE CASCADE)
TrackID (PK, FK → Track.TrackID, ON DELETE CASCADE)
LikedAt (DATETIME)
```

#### 9. **Follow**
```sql
UserID (PK, FK → User.UserID, ON DELETE CASCADE)
ArtistID (PK, FK → Artist.ArtistID, ON DELETE CASCADE)
FollowedAt (DATETIME)
```

#### 10. **PlayHistory**
```sql
HistoryID (PK, INT, AUTO_INCREMENT)
UserID (FK → User.UserID, ON DELETE CASCADE)
TrackID (FK → Track.TrackID, ON DELETE CASCADE)
PlayedAt (DATETIME)
Duration (INT) -- Số giây đã nghe
CompletedPlay (BOOLEAN)
```

**Ràng buộc quan trọng:**
- `UNIQUE(User.Email)` - Email không trùng
- `CHECK(Track.Duration > 0)` - Thời lượng > 0
- `ON DELETE CASCADE` - Áp dụng cho các bảng phụ thuộc
- `UNIQUE(PlaylistID, TrackID)` - Một bài chỉ xuất hiện 1 lần trong playlist
- `INDEX(Track.Title, Artist.Name)` - Tối ưu tìm kiếm

📄 File: `sql/database_schema_mysql.sql`

---

### 3.5 Prototype UI (5 màn hình)

**5 màn chính:**
1. **Home/Discover** - Trang chủ với đề xuất bài hát, album, playlist
2. **Player Mini + Track Detail** - Thanh player cố định với controls đầy đủ
3. **Search** - Tìm kiếm có dấu/không dấu tiếng Việt
4. **Playlist Detail** - Quản lý playlist với drag-drop sắp xếp
5. **Artist/Album Page** - Trang nghệ sĩ với danh sách bài hát, album

**Bonus:**
6. **Admin Panel** - CRUD Artist/Album/Track/Genre

**Tính năng đã implement:**
- ✅ Audio player (play/pause/seek/volume)
- ✅ Shuffle/Repeat modes
- ✅ Next/Previous track
- ✅ Like/Unlike, Follow/Unfollow
- ✅ Search (có/không dấu)
- ✅ Drag-drop playlist
- ✅ Play history logging
- ✅ Admin CRUD

📄 Link: `prototype/index.html`

---

### 3.6 Test Cases & Business Rules

#### Quy tắc nghiệp vụ (Business Rules)

**1. Unique Track trong Playlist**
- Một bài hát chỉ xuất hiện **1 lần** trong playlist
- Implementation: `UNIQUE KEY (PlaylistID, TrackID)`

**2. Scrobble Rule (30 giây)**
- Lịch sử nghe chỉ ghi khi play **≥ 30 giây** hoặc next sau ≥ 30s
- Implementation: JavaScript timer kiểm tra `currentTime`

**3. Like/Unlike Toggle**
- Click lần 1: INSERT vào `Like`
- Click lần 2: DELETE khỏi `Like`

**4. Playlist Visibility**
- `public`: Tất cả xem được
- `private`: Chỉ owner xem được

**5. Cascade Delete**
- Xóa Artist → CASCADE xóa Album + Track
- Xóa Album → CASCADE xóa Track
- Xóa Playlist → CASCADE xóa PlaylistTrack
- Xóa User → CASCADE xóa Playlist, Like, Follow, PlayHistory

**6. SortOrder trong Playlist**
- Drag-drop cập nhật `SortOrder`
- Insert mới: `SortOrder = MAX(SortOrder) + 1`

#### Test Cases (Tóm tắt)

| ID | Test Case | Business Rule | Expected Result | Priority |
|---|---|---|---|---|
| TC-01 | Thêm bài trùng vào playlist | Rule #1 | Error message | 🔴 High |
| TC-02 | Drag-drop sắp xếp | Rule #6 | SortOrder updated | 🔴 High |
| TC-03 | Like track lần đầu | Rule #3 | INSERT Like | 🔴 High |
| TC-04 | Unlike track | Rule #3 | DELETE Like | 🔴 High |
| TC-05 | Search không dấu | N/A | Tìm đúng kết quả | 🟡 Medium |
| TC-08 | Play < 30s | Rule #2 | Không ghi history | 🔴 High |
| TC-09 | Play ≥ 30s | Rule #2 | Ghi PlayHistory | 🔴 High |
| TC-11 | Xem playlist private | Rule #4 | Access denied | 🔴 High |
| TC-12 | Xóa Artist có Album | Rule #5 | CASCADE delete | 🔴 High |

📄 File: `test-cases/test-cases.md` (15 test cases chi tiết)

---

### 3.7 Video Demo (3-5 phút)

**Nội dung demo:**
- [0:00-0:30] Giới thiệu hệ thống và layout
- [0:30-1:00] Phát nhạc: play/pause/seek/volume
- [1:00-1:30] Tìm kiếm không dấu + phát từ kết quả
- [1:30-2:00] Playlist: thêm bài, drag-drop sắp xếp
- [2:00-2:30] Trang Artist: Follow, Like bài hát
- [2:30-3:00] Admin Panel: CRUD bài hát

📄 File: `demo/video-demo.mp4`

---

### 3.8 Báo cáo HTML trên GitHub

Trang `index.html` tổng hợp đầy đủ các diagram, prototype, test cases và video demo.

**GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

---

## 🔧 Công nghệ sử dụng

### Frontend
- HTML5, Tailwind CSS 3.x
- Vanilla JavaScript (ES6+)
- HTML5 Audio API
- HTML5 Drag & Drop API

### Database
- MySQL 8+
- 10 bảng với đầy đủ constraint và index

### Data
- JSON mock data
- LocalStorage (client-side cache)

---

## 🎮 Hướng dẫn chạy

```bash
# Cách 1: Mở trực tiếp
# Double-click file prototype/index.html

# Cách 2: Local server (khuyến nghị)
cd prototype
python -m http.server 8000
# Truy cập: http://localhost:8000
```

---

## 🎵 Dữ liệu mẫu

- **10 nghệ sĩ:** Sơn Tùng M-TP, Hòa Minzy, Đen Vâu, Mỹ Tâm, HIEUTHUHAI, Chi Pu, Bích Phương, Erik, Amee, Vũ
- **20 bài hát:** Lạc Trôi, Nơi Này Có Anh, Rời Bỏ, Mơ, Đưa Nhau Đi Trốn, 3107...
- **5 album:** m-tp M-TP, Rời Bỏ, Mơ, Tâm 9, Ai Cũng Phải Bắt Đầu Từ Đâu Đó
- **5 playlist:** Top Hits Việt 2024, Chill Vibes, My Favorites...

📄 File: `prototype/data/seed-data.json`

---

## 🔗 Links

- **GitHub:** [github.com/Harihuynh2007/music-streaming-spec](https://github.com/Harihuynh2007/music-streaming-spec)
- **GitHub Pages:** [harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

---

## 📞 Liên hệ

- **Sinh viên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **GitHub:** [@Harihuynh2007](https://github.com/Harihuynh2007)