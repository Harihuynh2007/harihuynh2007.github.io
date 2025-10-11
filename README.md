# 🎵 Music Streaming Web App

Báo cáo kiểm tra giữa kỳ - Nhập môn Công nghệ Phần mềm

## 📋 Thông tin sinh viên
- **Họ tên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **Ngày nộp:** 11/10/2025

## 🚀 Xem báo cáo

**GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)

**Hoặc mở file:** `index.html`

## 📁 Cấu trúc thư mục

```
music-streaming-spec/
├── index.html                  
├── README.md                   
│
├── diagrams/                   
│   ├── use-case-diagram.png
│   ├── sequence-play-track.png
│   ├── sequence-add-to-playlist.png
│   ├── er-diagram.png
│   └── erd-physical.png
│
├── prototype/                  
│   ├── index.html             
│   └── data/
│       └── seed-data.json     
│
├── test-cases/                 
│   └── test-cases.md          
│
├── demo/                       
│   └── video-demo.mp4         
│
└── screenshots/                
    ├── home.png
    ├── player.png
    ├── search.png
    ├── playlist.png
    ├── artist.png
    └── admin.png
```

## 🎯 Nội dung báo cáo

### 3.1 Use Case Diagram
Mô tả đầy đủ các actor (User, Admin, Audio CDN/Player) và use case chính của hệ thống bao gồm đăng nhập, tìm kiếm, phát nhạc, quản lý playlist, yêu thích, theo dõi nghệ sĩ và các chức năng quản trị.

### 3.2 Sequence Diagrams
Hai kịch bản chính:
- **SD-01:** Phát nhạc một bài với luồng User → WebApp → Player → TrackService → Audio CDN
- **SD-02:** Thêm bài vào Playlist với kiểm tra trùng lặp và cập nhật SortOrder

### 3.3 ER Diagram
Sơ đồ thực thể kết hợp gồm 10 thực thể: User, Artist, Album, Track, Genre, Playlist, PlaylistTrack, Like, Follow, PlayHistory với đầy đủ cardinality và ràng buộc.

### 3.4 ERD (Logical/Physical)
Schema cơ sở dữ liệu với kiểu dữ liệu PostgreSQL/MySQL, INDEX cho tối ưu tìm kiếm, khóa tổng hợp và các ràng buộc FK CASCADE.

### 3.5 Prototype UI
5 màn hình chính:
- **Home/Discover:** Trang chủ với đề xuất bài hát, album, playlist
- **Player Mini + Track Detail:** Thanh player cố định với controls đầy đủ
- **Search:** Tìm kiếm hỗ trợ có dấu/không dấu tiếng Việt
- **Playlist Detail:** Quản lý playlist với drag-drop sắp xếp
- **Artist/Album Page:** Trang nghệ sĩ với danh sách bài hát và album
- **Admin Panel:** Giao diện CRUD nghệ sĩ/album/bài hát/thể loại

### 3.6 Test Cases & Business Rules
15 test cases chi tiết bao gồm:
- Quản lý playlist (thêm bài trùng, drag-drop)
- Like/Unlike tracks
- Tìm kiếm tiếng Việt
- Play history (quy tắc 30 giây)
- Phân quyền và CASCADE delete

### 3.7 Demo Video
Video demo 3-5 phút minh họa các luồng chính: phát nhạc, tìm kiếm, quản lý playlist, trang nghệ sĩ, và admin panel.

### 3.8 Báo cáo HTML trên GitHub
Trang index.html tổng hợp đầy đủ các diagram, prototype, test cases và video demo với GitHub Pages.

## 🎮 Chạy prototype

### Cách 1: Mở trực tiếp
Mở file `prototype/index.html` bằng trình duyệt web.

### Cách 2: Local server
```bash
cd prototype
python -m http.server 8000
```
Truy cập: `http://localhost:8000`

## 🎵 Dữ liệu mẫu

- **10 nghệ sĩ:** Sơn Tùng M-TP, Hòa Minzy, Đen Vâu, Mỹ Tâm, HIEUTHUHAI, Chi Pu, Bích Phương, Erik, Amee, Vũ.
- **20 bài hát:** Lạc Trôi, Nơi Này Có Anh, Rời Bỏ, Mơ, Đưa Nhau Đi Trốn, Chúng Ta Của Hiện Tại, 3107, Ngủ Một Mình...
- **5 album:** m-tp M-TP, Rời Bỏ, Mơ, Tâm 9, Ai Cũng Phải Bắt Đầu Từ Đâu Đó
- **5 playlist:** Top Hits Việt 2024, Chill Vibes, My Favorites, Workout Mix, Late Night Vibes

## ✨ Tính năng đã implement

### Audio Player
- Play/Pause/Stop
- Seek bar
- Volume control
- Next/Previous track
- Shuffle mode
- Repeat mode
- Display current time/duration

### Core Features
- Search (có dấu + không dấu tiếng Việt)
- Like/Unlike tracks
- Play history logging (quy tắc 30 giây)
- Drag-drop playlist ordering
- Follow artist
- Admin CRUD interface

## 📊 Test Cases

**Tổng số:** 15 test cases

**Phân loại:**
- Playlist Management: TC-01, TC-02
- Like/Favorite: TC-03, TC-04
- Search: TC-05, TC-06, TC-07
- Play History: TC-08, TC-09, TC-10
- Permissions: TC-11, TC-12
- Audio Player: TC-13, TC-14, TC-15

Chi tiết tại `test-cases/test-cases.md`

## 🎬 Video Demo

**Thời lượng:** 3-5 phút

**Nội dung:**
- Giới thiệu hệ thống và layout
- Phát nhạc với các controls
- Tìm kiếm không dấu tiếng Việt
- Quản lý playlist với drag-drop
- Trang Artist/Album với Follow/Like
- Admin panel CRUD

## 🔧 Công nghệ sử dụng

- HTML5, Tailwind CSS, Vanilla JavaScript
- HTML5 Audio API
- HTML5 Drag and Drop API
- JSON (mock database)
- CSDL mô phỏng: MySQL 8+ schema
- JSON mock data

## 📝 Quy tắc nghiệp vụ

1. **Unique track in playlist:** Một bài hát chỉ xuất hiện 1 lần trong mỗi playlist
2. **Scrobble rule:** Lịch sử nghe chỉ ghi khi play ≥ 30 giây hoặc next sau ≥ 30s
3. **Like toggle:** Click Like lần 2 sẽ Unlike
4. **Playlist visibility:** Playlist private chỉ owner nhìn thấy
5. **Cascade delete:** Xóa Artist sẽ tự động xóa Album và Track liên quan

## 📸 Screenshots

Tất cả screenshots được lưu trong thư mục `screenshots/`:
- home.png - Trang chủ/Discover
- player.png - Player Mini
- search.png - Tìm kiếm
- playlist.png - Chi tiết Playlist
- artist.png - Trang Nghệ sĩ
- admin.png - Admin Panel

## 🔗 Links

- **GitHub Repo:** [https://github.com/Harihuynh2007/music-streaming-spec](https://github.com/Harihuynh2007/music-streaming-spec)
- **GitHub Pages:** [https://harihuynh2007.github.io/music-streaming-spec](https://harihuynh2007.github.io/music-streaming-spec)
- **Prototype:** [./prototype/index.html](./prototype/index.html)
- **Video Demo:** [./demo/video-demo.mp4](./demo/video-demo.mp4)

## 📞 Liên hệ

- **Sinh viên:** Huỳnh Minh Hải
- **MSSV:** N18DCCN053
- **GitHub:** [@Harihuynh2007](https://github.com/Harihuynh2007)