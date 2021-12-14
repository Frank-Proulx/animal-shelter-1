require ('pry')

class Album
  attr_accessor :id, :name, :artist, :genre, :year

  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0 

  def initialize(name, artist, genre, year, id)
    @name = name
    @artist = artist
    @genre = genre
    @year = year
    @id = id || @@total_rows += 1
  end

  def self.all
    @@albums.values()
  end

  def self.sold_all
    @@sold_albums.values()
  end

  def self.search(name_searched)
    arr_results = []
    @@albums.values.each do |album|
      if album.name == name_searched
        arr_results.push(album)
      end
    end
    arr_results
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.artist, self.genre, self.year, self.id)
  end

  def ==(album_to_compare)
    (self.name == album_to_compare.name) && (self.year == album_to_compare.year) && (self.genre == album_to_compare.genre) && (self.artist == album_to_compare.artist)
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name, artist, genre, year)
    @name = name
    @artist = artist
    @genre = genre
    @year = year
  end

  def delete
    @@albums.delete(self.id)
  end

  def self.sort
    array = @@albums.values.sort_by! &:name
    @@albums = {}
    array.each do |element|
      @@albums[element.id] = element
    end
  end

  def self.sort_sold
    array = @@sold_albums.values.sort_by! &:name
    @@sold_albums = {}
    array.each do |element|
      @@sold_albums[element.id] = element
    end
  end

  def sold
    @@sold_albums[self.id] = Album.new(self.name, self.artist, self.genre, self.year, self.id)
    self.delete
  end
end