require 'artist'
require 'spec_helper'

describe '#Artist' do

  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an artist") do
      artist = Artist.new({:name => "Thom Yorke", :id => nil}) 
      artist.save()
      expect(Artist.all).to(eq([artist]))
    end
  end

  describe('#==') do
    it("is the same artist if it has the same attributes as another artist") do
      artist1 = Artist.new({:name => "Thom Yorke", :id => nil})
      artist2 = Artist.new({:name => "Thom Yorke", :id => nil})
      expect(artist1).to(eq(artist2))
    end
  end

  describe('.clear') do
    it("clears all artists") do
      artist1 = Artist.new({:name => "Thom Yorke", :id => nil})
      artist1.save
      artist2 = Artist.new({:name => "Metronomy", :id => nil})
      artist2.save
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an artist by id") do
      artist1 = Artist.new({:name => "Thom Yorke", :id => nil})
      artist1.save
      artist2 = Artist.new({:name => "Metronomy", :id => nil})
      artist2.save
      expect(Artist.find(artist1.id)).to(eq(artist1))
    end
  end

  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album.save()
      artist.update({:album_name => "Blue"})
      assoc = DB.exec("SELECT * FROM albums_artists WHERE artist_id = #{artist.id} AND album_id = #{album.id};").first
      expect(assoc["album_id"].to_i).to(eq(album.id))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      artist1 = Artist.new({:name => "John Coltrane", :id => nil})
      artist1.save()
      artist2 = Artist.new({:name => "Metronomy", :id => nil})
      artist2.save()
      artist1.delete()
      expect(Artist.all).to(eq([artist2]))
    end
  end
  
#   describe('.sort') do
#     it("sorts albums by name") do
#       album1 = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
#       album2 = Album.new("A Love Supreme", "John Coltrane", "Jazz", 1960,nil)
#       album3 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
#       album1.save()
#       album2.save()
#       album3.save()
#       Album.sort
#       expect(Album.all).to(eq([album2, album3, album1]))
#     end
#   end

#   describe('#songs') do
#     it("returns an album's songs") do
#       album = Album.new("Giant Steps", nil)
#       album.save()
#       song = Song.new("Naima", album.id, nil)
#       song.save()
#       song2 = Song.new("Cousin Mary", album.id, nil)
#       song2.save()
#       expect(album.songs).to(eq([song, song2]))
#     end
#   end
end