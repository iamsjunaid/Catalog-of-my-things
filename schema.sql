--Create a schema.sql file with tables that will be analogical to the structure of the classes that we created

-- Create the 'genres' table
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

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

-- Create the 'label' table
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  color VARCHAR(255),
);

-- Create the 'book' table
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

-- Create the 'authors' table
CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

