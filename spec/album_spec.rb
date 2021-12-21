require 'album'
require 'spec_helper'

describe '#Album' do

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new({:name => "Giant Steps", :genre => "Jazz", :year => 1960, :id => nil}) 
      album.save()
      album2 = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album2 = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new({:name => "Giant Steps", :genre => "Jazz", :year => 1960, :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "Giant Steps", :genre => "Jazz", :year => 1960, :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => "Giant Steps", :genre => "Jazz", :year => 1960, :id => nil})
      album.save()
      album.update("Blue", "Jazz", 1960) # update for all attributes
      expect(album.name).to(eq("Blue"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({:name => "Giant Steps", :genre => "Jazz", :year => 1960, :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :genre => "Jazz", :year => 1960, :id => nil})
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
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