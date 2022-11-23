require "database_connection"
require "post_repository"
require 'pg'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it "Get all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 4

    expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq 'Title 1'
    expect(posts[0].contents).to eq 'Contents 1'
    expect(posts[0].views).to eq 10
    expect(posts[0].account_id).to eq 1

    expect(posts[1].id).to eq 2
    expect(posts[1].title).to eq 'Title 2'
    expect(posts[1].contents).to eq 'Contents 2'
    expect(posts[1].views).to eq 100
    expect(posts[1].account_id).to eq 2
  end

  it "Get a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq 1
    expect(post.title).to eq 'Title 1'
    expect(post.contents).to eq 'Contents 1'
    expect(post.views).to eq 10
    expect(post.account_id).to eq 1
  end

  it "Create a single post" do
    repo = PostRepository.new
    post = Post.new
    post.title = 'Title 5'
    post.contents = 'Contents 5'
    post.views = 0
    post.account_id = 4
    repo.create(post)

    all_posts = repo.all
    expect(all_posts.last.id).to eq 5
    expect(all_posts.last.title).to eq 'Title 5'
    expect(all_posts.last.contents).to eq 'Contents 5'
    expect(all_posts.last.account_id).to eq 4
    expect(all_posts.last.views).to eq 0
  end

  it "Delete a single post" do
    repo = PostRepository.new
    repo.delete(3)
    posts = repo.all
    expect(posts.length).to eq 3
    expect(posts[0].id).to eq 1
    expect(posts[1].id).to eq 2
    expect(posts[2].id).to eq 4
  end

  it "Update a single post" do
    repo = PostRepository.new
    new_post = repo.find(2)
    new_post.title = "Title 5"
    new_post.contents = "Contents 5"
    new_post.views = 1000
    repo.update(new_post)
    post = repo.find(2)
    expect(post.title).to eq "Title 5"
    expect(post.contents).to eq "Contents 5"
    expect(post.views).to eq 1000
    expect(post.account_id).to eq 2
  end

  it "create fails for negative views" do
    repo = PostRepository.new
    post = Post.new
    post.views = -1
    expect{repo.create(post)}.to raise_error "Post.views cannot be negative"
  end

  it "update fails for negative views" do
    repo = PostRepository.new
    post = repo.find(2)
    post.views = -1
    expect{repo.update(post)}.to raise_error "Post.views cannot be negative"
  end

  it "create fails if account_id doesn't exist in accounts table" do
    repo = PostRepository.new
    post = Post.new
    post.account_id = 5
    post.views = 5
    expect{repo.create(post)}.to raise_error PG::ForeignKeyViolation
  end

  it "update fails if account_id doesn't exist in accounts table" do
    repo = PostRepository.new
    post = repo.find(2)
    post.account_id = 5
    expect{repo.update(post)}.to raise_error PG::ForeignKeyViolation
  end
end