require_relative "lib/database_connection"
require_relative "lib/album_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform an SQL query on the database and get the result set.
repo = AlbumRepository.new
puts repo.find(3)