TRUNCATE TABLE accounts RESTART IDENTITY CASCADE;

INSERT INTO accounts (email, name) VALUES 
('tom@gmail.com', 'Thomas Seleiro'),
('robbie@gmail.com', 'Robbie Kirkbride'),
('shah@gmail.com', 'Shah Hussain'),
('chris@gmail.com', 'Chris Hutchinson');

INSERT INTO posts (title, contents, views, account_id) VALUES
('Title 1', 'Contents 1', 10, 1),
('Title 2', 'Contents 2', 100, 2),
('Title 3', 'Contents 3', 101, 1),
('Title 4', 'Contents 4', 1, 3);