# 🎵 Music Streaming Web App

Báo cáo kiểm tra giữa kỳ - Nhập môn Công nghệ Phần mềm

## 📋 Thông tin sinh viên
- **Họ tên:** [Tên của bạn]
- **MSSV:** [MSSV]
- **Lớp:** [Lớp]

## 🚀 Xem báo cáo

**GitHub Pages:** [https://[username].github.io/music-streaming-spec](https://[username].github.io/music-streaming-spec)

**Hoặc mở file:** `index.html`

## 📁 Cấu trúc thư mục

```
music-streaming-spec/
├── index.html                  # Trang tổng hợp (BẮT BUỘC)
├── README.md                   # File JSON: `prototype/data/seed-data.json`

## ✨ Tính năng đã implement

### Audio Player
- ✅ Play/Pause/Stop
- ✅ Seek bar (tua bài)
- ✅ Volume control
- ✅ Next/Previous track
- ✅ Shuffle mode
- ✅ Repeat mode
- ✅ Display current time / duration

### Core Features
- ✅ Search (có dấu + không dấu tiếng Việt)
- ✅ Like/Unlike tracks (toggle)
- ✅ Play history logging (mock 30s rule)
- ✅ Drag-drop playlist ordering
- ✅ Follow artist
- ✅ Admin CRUD interface

## 📊 Test Cases

Tổng số: **15 test cases**

**Nhóm chính:**
- Playlist Management (TC-01, TC-02)
- Like/Favorite (TC-03, TC-04)
- Search (TC-05, TC-06, TC-07)
- Play History/Scrobble (TC-08, TC-09, TC-10)
- Permissions (TC-11, TC-12)
- Audio Player (TC-13, TC-14, TC-15)

Xem chi tiết: `test-cases/test-cases.md`

## 🎬 Video Demo

**Thời lượng:** 3-5 phút

**Nội dung:**
1. Giới thiệu hệ thống
2. Phát nhạc (play/pause/seek/volume)
3. Tìm kiếm không dấu
4. Quản lý playlist (drag-drop)
5. Trang Artist/Album
6. Admin panel CRUD

File: `demo/video-demo.mp4`

## 🔧 Công nghệ sử dụng

- **Frontend:** HTML5, Tailwind CSS, Vanilla JavaScript
- **Audio:** HTML5 `<audio>` API
- **Drag & Drop:** HTML5 Drag and Drop API
- **Data:** JSON file (mock database)

## 📝 Business Rules

1. **Unique track in playlist**: Một bài hát chỉ xuất hiện 1 lần trong mỗi playlist
2. **Scrobble rule**: Lịch sử nghe chỉ ghi khi play ≥ 30 giây hoặc next sau ≥ 30s
3. **Like toggle**: Click Like lần 2 = Unlike
4. **Playlist visibility**: Private playlist chỉ owner thấy được
5. **Cascade delete**: Xóa Artist → tự động xóa Album + Track

## 🎯 Thang điểm

| Phần | Nội dung | Điểm |
|------|----------|------|
| 3.1 | Use Case + mô tả luồng | 15% |
| 3.2 | Sequence Diagrams | 10% |
| 3.3 | ER Diagram | 12.5% |
| 3.4 | ERD (Logical/Physical) | 12.5% |
| **3.5** | **Prototype UI** | **20%** ⭐ |
| **3.6** | **Test cases** | **20%** ⭐ |
| **3.7** | **Demo video** | **(trong 3.5)** |
| **3.8** | **GitHub HTML** | **10%** ⭐ |

**Phần của bạn: 50%** (3.5 + 3.6 + 3.8)

## 📸 Screenshots

### Home/Discover
![Home](./screenshots/home.png)

### Player Mini
![Player](./screenshots/player.png)

### Search
![Search](./screenshots/search.png)

### Playlist Detail
![Playlist](./screenshots/playlist.png)

### Artist Page
![Artist](./screenshots/artist.png)

### Admin Panel
![Admin](./screenshots/admin.png)

## 🔗 Links

- **GitHub Repo:** [https://github.com/[username]/music-streaming-spec](https://github.com/[username]/music-streaming-spec)
- **GitHub Pages:** [https://[username].github.io/music-streaming-spec](https://[username].github.io/music-streaming-spec)
- **Prototype:** [./prototype/index.html](./prototype/index.html)
- **Video Demo:** [./demo/video-demo.mp4](./demo/video-demo.mp4)

## 📞 Liên hệ

- Email: [email@student.hcmus.edu.vn]
- GitHub: [@username]

---

**Lưu ý:** Phần 3.1-3.4 (diagrams) do thành viên khác phụ trách, sẽ được cập nhật vào thư mục `/diagrams/` này
│
├── diagrams/                   # Phần 3.1-3.4 (người khác làm)
│   ├── use-case-diagram.png
│   ├── sequence-play-track.png
│   ├── sequence-add-to-playlist.png
│   ├── er-diagram.png
│   └── erd-physical.png
│
├── prototype/                  # Phần 3.5 (bạn làm)
│   ├── index.html             # Prototype 5 màn hình
│   └── data/
│       └── seed-data.json     # Dữ liệu mẫu
│
├── test-cases/                 # Phần 3.6 (bạn làm)
│   └── test-cases.md          # 15 test cases
│
├── demo/                       # Phần 3.7 (bạn làm)
│   └── video-demo.mp4         # Video demo 3-5 phút
│
└── screenshots/                # Ảnh chụp màn hình
    ├── home.png
    ├── player.png
    ├── search.png
    ├── playlist.png
    ├── artist.png
    └── admin.png
```

## 🎯 Deliverables

### ✅ Đã hoàn thành (3.5 - 3.8)

- [x] **3.5 Prototype UI** - 5 màn hình với audio player hoạt động
- [x] **3.6 Test cases** - 15 test cases với business rules
- [x] **3.7 Demo** - Video demo 3-5 phút
- [x] **3.8 GitHub** - Báo cáo HTML tổng hợp

### ⏳ Đang chờ (3.1 - 3.4 - người khác làm)

- [ ] 3.1 Use Case Diagram
- [ ] 3.2 Sequence Diagrams (2 kịch bản)
- [ ] 3.3 ER Diagram
- [ ] 3.4 ERD (Logical/Physical)

## 🎮 Chạy prototype

### Cách 1: Mở trực tiếp
```bash
# Mở file prototype/index.html bằng trình duyệt
```

### Cách 2: Local server (khuyến khích)
```bash
# Python 3
cd prototype
python -m http.server 8000

# Hoặc dùng Live Server extension (VS Code)
```

Truy cập: `http://localhost:8000`

## 🎵 Dữ liệu mẫu

- **10 nghệ sĩ**: Sơn Tùng M-TP, Hòa Minzy, Đen Vâu, Mỹ Tâm, HIEUTHUHAI...
- **20 bài hát**: Lạc Trôi, Nơi Này Có Anh, Rời Bỏ, Mơ...
- **5 album**: m-tp M-TP, Rời Bỏ, Mơ...
- **5 playlist**: Top Hits Việt 2024, Chill Vibes...

File