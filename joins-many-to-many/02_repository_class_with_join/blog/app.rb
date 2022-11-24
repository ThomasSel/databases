require_relative "lib/post_repository"
require_relative "lib/database_connection"

DatabaseConnection.connect("blog")

post_repo = PostRepository.new
post = post_repo.find_with_comments(1)

puts "  #{post.title.upcase}"
puts post.contents
puts "\n========================\n\n"
puts "Comments:"

post.comments.each do |comment|
  puts "\n#{comment.author_name}:"
  puts comment.contents
end