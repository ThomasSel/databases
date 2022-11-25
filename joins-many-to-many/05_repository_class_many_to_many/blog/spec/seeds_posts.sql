-- SET client_min_messages TO WARNING;

TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;

INSERT INTO "public"."posts" ("id", "title") VALUES
(1, 'How to use Git'),
(2, 'Ruby classes'),
(3, 'Using IRB'),
(4, 'My weekend in Edinburgh'),
(5, 'The best chocolate cake EVER'),
(6, 'A foodie week in Spain'),
(7, 'SQL basics');

INSERT INTO "public"."tags" ("id", "name") VALUES
(1, 'coding'),
(2, 'travel'),
(3, 'cooking'),
(4, 'ruby');

INSERT INTO "public"."posts_tags" ("post_id", "tag_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);

ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id");
ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id");
