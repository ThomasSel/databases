require 'Album'
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
    sql_code = "SELECT id, title, release_year, artist_id FROM albums WHERE id = #{id};"
    result = DatabaseConnection.exec_params(sql_code,[])
    return make_album(result).first
  end
  
  private

  def make_album(query)
    albums = []
    query.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      album.artist_id = record["artist_id"]
      albums << album
    end
    return albums
  end

end