require "tag_repository"

def reset_tags_table
  sql_seed = File.read("spec/seeds_tags.sql")
  connection = PG.connect( { host: "127.0.0.1", dbname: "blog_test" } )
  connection.exec(sql_seed)
end

RSpec.describe TagRepository do
  before(:each) do
    reset_tags_table
  end

  it "Get all tags for the 6th post" do
    tag_repo = TagRepository.new
    tags = tag_repo.find_with_post(6)
    
    expect(tags.length).to eq 2
    
    expect(tags.first.id).to eq 2
    expect(tags.first.name).to eq "travel"
    
    expect(tags.last.id).to eq 3
    expect(tags.last.name).to eq "cooking"
  end

  xit "Try to look for a post that isn't in the database" do
    tag_repo = TagRepository.new
    expect(ag_repo.find_with_post(8)).to eq []
  end
end