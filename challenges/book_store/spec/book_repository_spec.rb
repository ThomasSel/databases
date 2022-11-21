require 'book_repository'

def reset_books_table
  seed_sql = File.read('spec/seeds_books.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  it "all returns an array of books from table" do
    repo = BookRepository.new

    books = repo.all

    expect(books.length).to eq 5

    expect(books[0].id).to eq "1"
    expect(books[0].title).to eq 'Nineteen Eighty-Four'
    expect(books[0].author_name).to eq 'George Orwell'

    expect(books[1].id).to eq "2"
    expect(books[1].title).to eq 'Mrs Dalloway'
    expect(books[1].author_name).to eq 'Virginia Woolf'
    # (your tests will go here).
  end

  
  it "returns the third book" do
    repo = BookRepository.new

    book = repo.find(3)

    expect(book.id).to eq "3"
    expect(book.title).to eq 'Emma'
    expect(book.author_name).to eq 'Jane Austen'
  end
end