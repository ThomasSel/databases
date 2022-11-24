SELECT albums.id, albums.title
FROM albums
JOIN artists
	ON albums.artist_id = artists.id
WHERE artists.name = 'Taylor Swift';

SELECT albums.id, albums.title
FROM albums
JOIN artists
	ON albums.artist_id = artists.id
WHERE artists.name = 'Pixies'
	AND albums.release_year = 1988;

SELECT albums.id, title
FROM albums
JOIN artists
	ON artist_id = artists.id
WHERE name = 'Nina Simone'
	AND release_year > 1975;