TRUNCATE TABLE posts RESTART IDENTITY CASCADE;

INSERT INTO posts (title, contents) VALUES
('Title_1', 'Contents_1'),
('Title_2', 'Contents_2'),
('Title_3', 'Contents_3');

INSERT INTO comments (contents, author_name, post_id) VALUES
('contents_1', 'author_1', 1),
('contents_2', 'author_1', 1),
('contents_1', 'author_2', 1),
('contents_1', 'author_3', 3);