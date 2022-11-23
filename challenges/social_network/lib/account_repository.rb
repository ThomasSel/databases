require_relative "database_connection"
require_relative "account"

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = "SELECT id, email, name FROM accounts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    accounts = []
    result_set.each do |record|
      accounts << unpack_record(record)
    end
    return accounts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = "SELECT id, email, name FROM accounts WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    return unpack_record(record)
  end

  def create(account)
    sql = 'INSERT INTO accounts (email, name) VALUES ($1, $2);'
    params = [account.email, account.name]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(account)
    sql = 'UPDATE accounts SET email = $1, name = $2 WHERE id = $3;'
    params = [account.email, account.name, account.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private

  def unpack_record(record)
    account = Account.new
    account.id = record["id"].to_i
    account.email = record["email"]
    account.name = record["name"]
    return account
  end
end