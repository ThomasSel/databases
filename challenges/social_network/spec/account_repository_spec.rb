require "account_repository"

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  it "get all accounts" do
    repo = AccountRepository.new

    accounts = repo.all

    expect(accounts.length).to eq 4

    expect(accounts[0].id).to eq 1
    expect(accounts[0].email).to eq 'tom@gmail.com'
    expect(accounts[0].name).to eq 'Thomas Seleiro'

    expect(accounts[1].id).to eq 2
    expect(accounts[1].email).to eq 'robbie@gmail.com'
    expect(accounts[1].name).to eq 'Robbie Kirkbride'
  end

    # 2
  it "Get a single account" do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq 1
    expect(account.email).to eq 'tom@gmail.com'
    expect(account.name).to eq 'Thomas Seleiro'
  end

  it "Create a single account" do
    repo = AccountRepository.new
    account = Account.new
    account.email = 'eoin@gmail.com'
    account.name = 'Eoin Power'
    repo.create(account)

    all_accounts = repo.all
    expect(all_accounts.last.id).to eq 5
    expect(all_accounts.last.email).to eq 'eoin@gmail.com'
    expect(all_accounts.last.name).to eq 'Eoin Power'
  end

  it "Delete a single account" do
    repo = AccountRepository.new
    repo.delete(3)
    accounts = repo.all
    expect(accounts.length).to eq 3
    expect(accounts[0].id).to eq 1
    expect(accounts[1].id).to eq 2
    expect(accounts[2].id).to eq 4
  end

  it "Update a single account" do
    repo = AccountRepository.new
    new_account = repo.find(2)
    new_account.email = "william@gmail.com"
    new_account.name = "William Kirkbride"
    repo.update(new_account)
    account = repo.find(2)
    expect(account.email).to eq "william@gmail.com"
    expect(account.name).to eq "William Kirkbride"
  end
end