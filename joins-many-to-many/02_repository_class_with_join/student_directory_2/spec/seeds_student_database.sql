TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;

INSERT INTO cohorts (name, starting_date) VALUES
('January', '2023-01-01'),
('February', '2023-02-01'),
('March', '2023-03-01');

INSERT INTO students (name, cohort_id) VALUES
('Student One', 1),
('Student Two', 1),
('Student Three', 2),
('Student Four', 2),
('Student Five', 3);