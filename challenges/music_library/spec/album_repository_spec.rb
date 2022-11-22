require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  if ENV["PG_password"] 
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', password: ENV["PG_password"] })
  else
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
  end
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
  it "all returns a list of albums" do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq 4

    expect(albums[0].id).to eq  "1"
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq "1989"
    expect(albums[0].artist_id).to eq "1"

    expect(albums[1].id).to eq "2"
    expect(albums[1].title).to eq 'Surfer Rosa'
    expect(albums[1].release_year).to eq "1988"
    expect(albums[1].artist_id).to eq "1"
  end
  # 2
  it " Find third albums" do

    repo = AlbumRepository.new

    album = repo.find(3)

    expect(album.id).to eq  "3"
    expect(album.title).to eq 'Super Trouper'
    expect(album.release_year).to eq  "1980"
    expect(album.artist_id).to eq "2"
  end
end