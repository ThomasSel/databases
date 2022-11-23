require_relative "../app"

RSpec.describe Application do
  it "runs the command line music library manager and asks for the albums" do
    io_double = double(:fake_io)
    expect(io_double).to receive(:puts).with("\nWelcome to the music library manager!\n").ordered
    expect(io_double).to receive(:puts).with("What would you like to do?").ordered
    expect(io_double).to receive(:puts).with(" 1 - List all albums").ordered
    expect(io_double).to receive(:puts).with(" 2 - List all artists\n").ordered
    expect(io_double).to receive(:print).with("Enter your choice: ").ordered
    expect(io_double).to receive(:gets).and_return("1\n").ordered
    expect(io_double).to receive(:puts).with("\nHere is the list of albums:").ordered
    expect(io_double).to receive(:puts).with(" * 1 - Doolittle").ordered
    expect(io_double).to receive(:puts).with(" * 2 - Surfer Rosa").ordered
    expect(io_double).to receive(:puts).with(" * 3 - Super Trouper").ordered
    expect(io_double).to receive(:puts).with(" * 4 - Bossanova").ordered
    
    album_repo_double = double(:fake_album_repo)
    expect(album_repo_double).to receive(:all).and_return([
      double(:fake_album, id: 1, title: "Doolittle"),
      double(:fake_album, id: 2, title: "Surfer Rosa"),
      double(:fake_album, id: 3, title: "Super Trouper"),
      double(:fake_album, id: 4, title: "Bossanova")
    ])

    artist_repo_double = double(:fake_artist_repo)
    
    app = Application.new(
      "music_library_test",
      io_double,
      album_repo_double,
      artist_repo_double
    )
    app.run
  end

  it "runs the command line music library manager and asks for the artists" do
    io_double = double(:fake_io)
    expect(io_double).to receive(:puts).with("\nWelcome to the music library manager!\n").ordered
    expect(io_double).to receive(:puts).with("What would you like to do?").ordered
    expect(io_double).to receive(:puts).with(" 1 - List all albums").ordered
    expect(io_double).to receive(:puts).with(" 2 - List all artists\n").ordered
    expect(io_double).to receive(:print).with("Enter your choice: ").ordered
    expect(io_double).to receive(:gets).and_return("2\n").ordered
    expect(io_double).to receive(:puts).with("\nHere is the list of artists:").ordered
    expect(io_double).to receive(:puts).with(" * 1 - Pixies").ordered
    expect(io_double).to receive(:puts).with(" * 2 - ABBA").ordered
    
    album_repo_double = double(:fake_album_repo)

    artist_repo_double = double(:fake_artist_repo)
    expect(artist_repo_double).to receive(:all).and_return([
      double(:fake_artist, id: 1, name: "Pixies"),
      double(:fake_artist, id: 2, name: "ABBA")
    ])
    
    app = Application.new(
      "music_library_test",
      io_double,
      album_repo_double,
      artist_repo_double
    )
    app.run
  end

  it "asks for input again if a wrong input is given" do
    io_double = double(:fake_io)
    expect(io_double).to receive(:puts).with("\nWelcome to the music library manager!\n").ordered
    2.times do
      expect_options(io_double)
      expect(io_double).to receive(:gets).and_return("Not correct\n").ordered
  end
    expect_options(io_double)
    expect(io_double).to receive(:gets).and_return("1\n").ordered
    expect(io_double).not_to receive(:gets)
    allow(io_double).to receive(:puts)

    album_repo_double = double(:fake_album_repo, all: [])

    artist_repo_double = double(:fake_artist_repo, all: [])
    
    app = Application.new(
      "music_library_test",
      io_double,
      album_repo_double,
      artist_repo_double
    )
    app.run
  end
end

def expect_options(dbl)
  expect(dbl).to receive(:puts).with("What would you like to do?").ordered
  expect(dbl).to receive(:puts).with(" 1 - List all albums").ordered
  expect(dbl).to receive(:puts).with(" 2 - List all artists\n").ordered
  expect(dbl).to receive(:print).with("Enter your choice: ").ordered
end