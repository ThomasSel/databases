require_relative "database_connection"
require_relative "artist"

class ArtistRepository
  def all
    sql_query = "SELECT id, name, genre FROM artists;"
    query_result = DatabaseConnection.exec_params(sql_query, [])

    artists = []
    query_result.each do |record|
      artists << unpack_artist(record)
    end
    return artists
  end

  private

  def unpack_artist(record)
    artist = Artist.new
    artist.id = record["id"].to_i
    artist.name = record["name"]
    artist.genre = record["genre"]
    return artist
  end
end