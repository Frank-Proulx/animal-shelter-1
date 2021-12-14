require 'rspec'
require 'album'
require 'pry'

describe '#Album' do

  before(:each) do
    Album.clear()
  end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil) # nil added as second argument
      album.save()
      album2 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil) # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      album2 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album.save()
      album2 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album.save()
      album2 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album.save()
      album.update("A Love Supreme", "John Coltrane", "Jazz", 1960)
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album.save()
      album2 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end
  
  describe('.search') do
    it("returns array of result when search method called with name") do
      album = Album.new("A Love Supreme", "John Coltrane", "Jazz", 1960,nil)
      album.save()
      expect(Album.search("A Love Supreme")).to(eq([album]))
    end
  end
  
  describe('.sort') do
    it("sorts albums by name") do
      album1 = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album2 = Album.new("A Love Supreme", "John Coltrane", "Jazz", 1960,nil)
      album3 = Album.new("Blue", "John Coltrane", "Jazz", 1960, nil)
      album1.save()
      album2.save()
      album3.save()
      Album.sort
      expect(Album.all).to(eq([album2, album3, album1]))
    end
  end

  describe('#sold') do
    it("sorts albums by name") do
      album1 = Album.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
      album1.save()
      album1.sold
      expect(Album.sold_all).to(eq([album1]))
    end
  end
end