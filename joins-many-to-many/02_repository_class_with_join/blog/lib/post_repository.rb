require_relative "database_connection"
require_relative "post"
require_relative "comment"

class PostRepository
  def find_with_comments(id)
    sql_query =
    "SELECT
      posts.id AS post_id,
      posts.title,
      posts.contents,
      comments.id AS comment_id,
      comments.contents AS comment_contents,
      comments.author_name
    FROM posts
    JOIN comments
      ON posts.id = comments.post_id
    WHERE posts.id = $1;"
    query_results = DatabaseConnection.exec_params(sql_query, [id])

    post = Post.new
    post.id = query_results.first["post_id"].to_i
    post.title = query_results.first["title"]
    post.contents = query_results.first["contents"]

    query_results.each do |record|
      comment = Comment.new
      comment.id = record["comment_id"].to_i
      comment.contents = record["comment_contents"]
      comment.author_name = record["author_name"]
      comment.post_id = record["post_id"].to_i
      post.comments << comment
    end

    return post
  end
end