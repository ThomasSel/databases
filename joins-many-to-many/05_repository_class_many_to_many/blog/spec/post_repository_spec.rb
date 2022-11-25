require "post_repository"

def reset_posts_table
  sql_seed = File.read("spec/seeds_posts.sql")
  connection = PG.connect( { host: "127.0.0.1", dbname: 'blog_test' })
  connection.exec(sql_seed)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "Get all posts with the tag 'coding'" do
    post_repo = PostRepository.new
    posts = post_repo.find_with_tag("coding")

    expect(posts.length).to eq 4

    expect(posts.first.id).to eq 1
    expect(posts.first.title).to eq "How to use Git"

    expect(posts.last.id).to eq 7
    expect(posts.last.title).to eq "SQL basics"
  end

  it "Try to look for a tag that isn't in the database" do
    post_repo = PostRepository.new
    expect(post_repo.find_with_tag("music")).to eq []
  end
end