SELECT
	posts.id,
	posts.title
FROM posts
JOIN posts_tags
	ON posts.id = posts_tags.post_id
JOIN tags
	ON posts_tags.tag_id = tags.id
WHERE
	tags.name = 'travel';

INSERT INTO tags (id, name) VALUES (5, 'sql');
INSERT INTO posts_tags (tag_id, post_id) VALUES (5, 7);

SELECT
	posts.id,
	posts.title
FROM posts
JOIN posts_tags
	ON posts.id = posts_tags.post_id
JOIN tags
	ON posts_tags.tag_id = tags.id
WHERE
	tags.name = 'sql';