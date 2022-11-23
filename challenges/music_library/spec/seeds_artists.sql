TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;

-- First insert into artists
INSERT INTO artists (name, genre) VALUES
('Pixies', 'Rock'),
('ABBA', 'Pop');

-- Then insert into albums
INSERT INTO albums (title, release_year, artist_id) VALUES
('Doolittle', 1989, 1),
('Surfer Rosa', 1988, 1),
('Super Trouper', 1980, 2),
('Bossanova', 1990, 1);