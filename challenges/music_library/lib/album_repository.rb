require_relative 'Album'

class AlbumRepository

  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
    sql_code = "SELECT id, title, release_year, artist_id FROM albums;"
    result = DatabaseConnection.exec_params(sql_code,[])
    return make_album(result)
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;

    # Returns a single Album object.
    sql_code = "SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;"
    result = DatabaseConnection.exec_params(sql_code,[id])
    return make_album(result).first
  end

  def create(album)
    sql_code = "INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);"
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql_code, params)
  end

  def delete(id)
    sql_code = "DELETE FROM albums WHERE id = $1;"
    DatabaseConnection.exec_params(sql_code, [id])
  end
  
  private

  def make_album(query)
    albums = []
    query.each do |record|
      album = Album.new
      album.id = record["id"].to_i
      album.title = record["title"]
      album.release_year = record["release_year"].to_i
      album.artist_id = record["artist_id"].to_i
      albums << album
    end
    return albums
  end

end