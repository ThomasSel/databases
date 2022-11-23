# Post Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: posts

Columns:
id | title | contents | views | account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
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
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
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
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :contents, :views, :account_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, contents, views, account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, contents, views, account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  def create(post)
    # post is an instance of Post object
    # INSERT INTO posts (title, contents, views, account_id) VALUES ($1, $2, $3, $4);
    # Returns nothing
  end

  def delete(id)
    # id is an integer
    # DELETE FROM posts WHERE id = $1;
    # Returns nothing
  end

  def update(post)
    # post is an instance of Post object
    # UPDATE posts SET title = $1, contents = $2, views = $3, account_id = $4 WHERE id = $5;
    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  4

posts[0].id # =>  1
posts[0].title # =>  'Title 1'
posts[0].contents # =>  'Contents 1'
posts[0].views # =>  10
posts[0].account_id # =>  1

posts[1].id # =>  2
posts[1].title # =>  'Title 2'
posts[1].contents # =>  'Contents 2'
posts[1].views # =>  100
posts[1].account_id # =>  2

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'Title 1'
post.contents # =>  'Contents 1'
post.views # =>  10
post.account_id # =>  1

# 3
# Create a single post

repo = PostRepository.new
post = Post.new
post.title #=> 'Title 5'
post.contents #=> 'Contents 5'
post.views #=> 0
post.account_id #=> 4
repo.create(post)

all_posts = repo.all
all_posts.last.id #=> 5
all_posts.last.title #=> 'Title 5'
all_posts.last.contents #=> 'Contents 5'
all_posts.last.account_id #=> 4
all_posts.last.views #=> 0

# 4
# Delete a single post
repo = PostRepository.new
repo.delete(3)
posts = repo.all
posts.length #=> 3
posts[0].id #=> 1
posts[1].id #=> 2
posts[2].id #=> 4

# 5
# Update a single post
repo = PostRepository.new
new_post = repo.find(2)
new_post.title = "Title 5"
new_post.contents = "Contents 5"
new_post.views = 1000
repo.update(new_post)
post = repo.find(2)
post.title # => "Title 5"
post.contents # => "Contents 5"
post.views # => 1000
post.account_id # => 2

# 6
# create fails for negative views
repo = PostRepository.new
post = Post.new
post.views = -1
repo.create(post) # => raises error "Post.views cannot be negative"

# 7
# update fails for negative views
repo = PostRepository.new
post = repo.find(2)
post.views = -1
repo.update(post) # => raises error "Post.views cannot be negative"

# 8
# create fails if account_id doesn't exist in accounts table
repo = PostRepository.new
post = Post.new
post.account_id = 5
repo.create(post) # => raises error

# 9
# update fails if account_id doesn't exist in accounts table
repo = PostRepository.new
post = repo.find(2)
post.account_id = 5
repo.update(post) # => raises error

# 10
# Deleting account deletes all posts linked to it
account_repo = AccountReporsitory.new
post_repo = PostReporsitory.new
account_repo.delete(1)
all_posts = post_repo.all
all_posts.length # => 2
all_posts.first.id # => 2
all_posts.first.title # => "Title 2"
all_posts.first.contents # => "Contents 2"
all_posts.first.views # => 100
all_posts.first.account_id # => 2
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/posts_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```
