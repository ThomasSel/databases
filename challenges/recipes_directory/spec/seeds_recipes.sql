TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, avg_cooking_time, rating) VALUES
('Pasta', 15, 4),
('Risotto', 45, 5),
('Chicken', 10, 5);