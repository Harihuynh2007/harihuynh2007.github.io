-- =======================================
-- Music Streaming Web App - MySQL DDL (InnoDB)
-- Section 3.4: ERD (Logical/Physical)
-- =======================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE users (
  user_id       INT AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(120) NOT NULL,
  email         VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role          ENUM('user','admin') NOT NULL DEFAULT 'user',
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status        VARCHAR(32) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_users_lower_email ON users ((LOWER(email)));

CREATE TABLE artists (
  artist_id  INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(160) NOT NULL UNIQUE,
  bio        TEXT,
  country    VARCHAR(80),
  debut_year INT CHECK (debut_year >= 1900),
  avatar_url TEXT,
  status     VARCHAR(32) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_artists_name ON artists (name);

CREATE TABLE genres (
  genre_id    INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(120) NOT NULL UNIQUE,
  description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE albums (
  album_id    INT AUTO_INCREMENT PRIMARY KEY,
  artist_id   INT NOT NULL,
  title       VARCHAR(200) NOT NULL,
  release_date DATE,
  cover_url   TEXT,
  status      VARCHAR(32) DEFAULT 'published',
  CONSTRAINT fk_albums_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_albums_title ON albums (title);

CREATE TABLE tracks (
  track_id       INT AUTO_INCREMENT PRIMARY KEY,
  album_id       INT NULL,
  title          VARCHAR(200) NOT NULL,
  duration       INT NOT NULL CHECK (duration > 0),
  audio_url      TEXT NOT NULL,
  lyrics         TEXT,
  genre_id       INT,
  explicit       BOOLEAN NOT NULL DEFAULT FALSE,
  publish_status ENUM('draft','published','blocked') NOT NULL DEFAULT 'published',
  CONSTRAINT fk_tracks_album FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL,
  CONSTRAINT fk_tracks_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_tracks_title ON tracks (title);

CREATE TABLE playlists (
  playlist_id    INT AUTO_INCREMENT PRIMARY KEY,
  owner_user_id  INT NOT NULL,
  title          VARCHAR(200) NOT NULL,
  description    TEXT,
  visibility     ENUM('public','private') NOT NULL DEFAULT 'public',
  cover_url      TEXT,
  created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_playlists_owner FOREIGN KEY (owner_user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE playlist_tracks (
  playlist_id  INT NOT NULL,
  track_id     INT NOT NULL,
  sort_order   INT,
  added_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id, track_id),
  CONSTRAINT fk_pl_tracks_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE,
  CONSTRAINT fk_pl_tracks_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_playlist_tracks_sort ON playlist_tracks (playlist_id, sort_order);

CREATE TABLE likes (
  user_id   INT NOT NULL,
  track_id  INT NOT NULL,
  liked_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, track_id),
  CONSTRAINT fk_likes_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_likes_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE follows (
  user_id     INT NOT NULL,
  artist_id   INT NOT NULL,
  followed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, artist_id),
  CONSTRAINT fk_follows_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_follows_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE play_history (
  history_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id      INT NOT NULL,
  track_id     INT NOT NULL,
  played_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  device       VARCHAR(120),
  position_sec INT NOT NULL CHECK (position_sec >= 0),
  CONSTRAINT fk_ph_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_ph_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_play_history_user_time ON play_history (user_id, played_at);
CREATE INDEX idx_play_history_track_time ON play_history (track_id, played_at);

SET FOREIGN_KEY_CHECKS=1;
