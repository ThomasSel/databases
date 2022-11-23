# Account Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: accounts

Columns:
id | email | name
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
# Table name: students

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Account
  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :name
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, name FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, name FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  def create(account)
    # Account is an instance of Account object
    # INSERT INTO accounts (email, name) VALUES ($1, $2);
    # Returns nothing
  end

  def delete(id)
    # id is an integer
    # DELETE FROM accounts WHERE id = $1;
    # Returns nothing
  end

  def update(account)
    # Account is an instance of Account object
    # UPDATE accounts SET email = $1, name = $2 WHERE id = $3;
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
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  4

accounts[0].id # =>  1
accounts[0].email # =>  'tom@gmail.com'
accounts[0].name # =>  'Thomas Seleiro'

accounts[1].id # =>  2
accounts[1].email # =>  'robbie@gmail.com'
accounts[1].name # =>  'Robbie Kirkbride'

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  1
account.email # =>  'tom@gmail.com'
account.name # =>  'Thomas Seleiro'

# 3
# Create a single account

repo = AccountRepository.new
account = Account.new
account.email #=> 'eoin@gmail.com'
account.name #=> 'Eoin Power'
repo.create(account)

all_accounts = repo.all
all_accounts.last.id #=> 5
all_accounts.last.email #=> 'eoin@gmail.com'
all_accounts.last.name #=> 'Eoin Power'

# 4
# Delete a single account
repo = AccountRepository.new
repo.delete(3)
accounts = repo.all
accounts.length #=> 3
accounts[0].id #=> 1
accounts[1].id #=> 2
accounts[2].id #=> 4

# 5
# Update a single account
repo = AccountRepository.new
new_account = repo.find(2)
new_account.email = "william@gmail.com"
new_account.name = "William Kirkbride"
repo.update(new_account)
account = repo.find(2)
account.email #=> "william@gmail.com"
account.name # => "William Kirkbride"
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/accounts_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
