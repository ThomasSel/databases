require_relative "post"

class PostRepository
  def find_with_tag(tag)
    sql_query = 
    "SELECT
      posts.id,
      posts.title
    FROM posts
    JOIN posts_tags
      ON posts.id = posts_tags.post_id
    JOIN tags
      ON posts_tags.tag_id = tags.id
    WHERE tags.name = $1;"
    query_results = DatabaseConnection.exec_params(sql_query, [tag])

    posts = []
    query_results.each do |record|
      post = Post.new
      post.id = record["id"].to_i
      post.title = record["title"]
      posts << post
    end
    return posts
  end
end