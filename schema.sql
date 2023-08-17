--Create a schema.sql file with tables that will be analogical to the structure of the classes that we created

-- Create the 'music_albums' table
CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  archived BOOLEAN
  on_spotify BOOLEAN NOT NULL,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (label_id) REFERENCES labels(id)
);

-- Create INDEXES for every FK to improve performance on 'music_albums' table
CREATE INDEX idx_genre_id ON music_albums (genre_id);
CREATE INDEX idx_author_id ON music_albums (author_id);
CREATE INDEX idx_label_id ON music_albums (label_id);

-- Create the 'genres' table
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Create the 'books' table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  archived BOOLEAN,
  publisher VARCHAR(255),
  cover_state VARCHAR(255),
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (label_id) REFERENCES labels(id)
  );

-- Create INDEXES for every FK to improve performance on 'books' table
CREATE INDEX idx_genre_id ON books (genre_id);
CREATE INDEX idx_author_id ON books (author_id);
CREATE INDEX idx_label_id ON books (label_id);

-- Create the 'labels' table
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  color VARCHAR(255),
);

-- Create the 'games' table
CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  last_played_at DATE,
  archived BOOLEAN,
  multiplayer BOOLEAN NOT NULL,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (label_id) REFERENCES labels(id)
  );

-- Create INDEXES for every FK to improve performance on 'games' table
CREATE INDEX idx_genre_id ON games (genre_id);
CREATE INDEX idx_author_id ON games (author_id);
CREATE INDEX idx_label_id ON games (label_id);

-- Create the 'authors' table
CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);
