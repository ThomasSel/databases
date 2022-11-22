require_relative "lib/database_connection"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform an SQL query on the database and get the result set.
repo = AlbumRepository.new
repo.all

# Print out each record from the result set.
result.each do |record|
  puts record
end