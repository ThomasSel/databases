# Post Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `posts`*

```
# EXAMPLE

Table: posts

Columns:
id | title
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_posts.sql)

TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

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

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)

class Student
  attr_accessor :id, :title
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository
  # Gets all the posts with the given tag
  # One argument: tag to search for (string)
  def find_by_tag(tag)
    # Executes the SQL query:
    # SELECT
    #   posts.id,
    #   posts.title
    # FROM posts
    # JOIN posts_tags
    #   ON posts.id = posts_tags.post_id
    # JOIN tags
    #   ON posts_tags.tag_id = tags.id
    # WHERE tags.name = $1;

    # Returns an array of Post objects.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts with the tag 'coding'

post_repo = PostRepository.new
posts = post_repo.find_with_tag("coding")

posts.length # => 4

posts.first.id # => 1
posts.first.title # => "How to use Git"

posts.last.id # => 7
posts.last.title # => "SQL basics"

# 2
# Try to look for a tag that isn't in the database

post_repo = PostRepository.new
post_repo.find_with_tag("music") # => []
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do 
    reset_posts_table
  end
end
```
