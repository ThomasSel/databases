class Post
  attr_accessor :id, :title, :contents, :comments

  def initialize
    @comments = []
  end
end