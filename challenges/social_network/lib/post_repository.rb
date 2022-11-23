require "database_connection"
require "post"

class PostRepository
  def all
    sql = "SELECT id, title, contents, views, account_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []
    result_set.each do |record|
      posts << unpack_record(record)
    end
    return posts
  end

  def find(id)
    sql = "SELECT id, title, contents, views, account_id FROM posts WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    return unpack_record(record)
  end

  def create(post)
    fail "Post.views cannot be negative" if post.views < 0
    sql = 'INSERT INTO posts (title, contents, views, account_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.contents, post.views, post.account_id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(post)
    fail "Post.views cannot be negative" if post.views < 0
    sql = 'UPDATE posts SET title = $1, contents = $2, views = $3, account_id = $4 WHERE id = $5;'
    params = [post.title, post.contents, post.views, post.account_id, post.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private

  def unpack_record(record)
    post = Post.new
    post.id = record["id"].to_i
    post.title = record["title"]
    post.contents = record["contents"]
    post.views = record["views"].to_i
    post.account_id = record["account_id"].to_i
    return post
  end
end