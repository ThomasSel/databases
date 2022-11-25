require_relative "database_connection"
require_relative "tag"

class TagRepository
  def find_with_post(id)
    sql_query =
    "SELECT
      tags.id,
      tags.name
    FROM tags
    JOIN posts_tags
      ON tags.id = posts_tags.tag_id
    JOIN posts
      ON posts_tags.post_id = posts.id
    WHERE posts.id = $1;"
    query_results = DatabaseConnection.exec_params(sql_query, [id])

    tags = []
    query_results.each do |record|
      tag = Tag.new
      tag.id = record["id"].to_i
      tag.name = record["name"]
      tags << tag
    end
    return tags
  end
end