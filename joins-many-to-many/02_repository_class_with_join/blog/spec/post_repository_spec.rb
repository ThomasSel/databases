require "pg"
require "post_repository"

def reset_tables
  seed_sql = File.read("spec/seeds_tables.sql")
  connection = PG.connect( { host: "127.0.0.1", dbname: "blog"} )
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_tables
  end

  it "#find_with_comments gets a post and its comments" do
    post_repo = PostRepository.new
    post = post_repo.find_with_comments(1)

    expect(post.id).to eq 1
    expect(post.title).to eq "Title_1"
    expect(post.contents).to eq "Contents_1"

    expect(post.comments.length).to eq 3
    expect(post.comments.last.id).to eq 3
    expect(post.comments.last.contents).to eq "contents_1"
    expect(post.comments.last.author_name).to eq "author_2"
    expect(post.comments.last.post_id).to eq 1
  end
end