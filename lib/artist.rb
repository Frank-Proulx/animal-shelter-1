require ('pry')

class Album
  attr_accessor :id, :name, :artist, :genre, :year, :sold

  # @@albums = {}
  # @@sold_albums = {}
  # @@total_rows = 0 

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @artist = attributes.fetch(:artist)
    @genre = attributes.fetch(:genre)
    @year = attributes.fetch(:year)
    @id = attributes.fetch(:id)
    @sold = attributes.fetch(:sold)
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      artist = album.fetch("artist")
      genre = album.fetch("genre")
      year = album.fetch("year").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :artist => artist, :genre => genre, :year => year, :id => id}))
    end
    albums
  end

  def self.sold_all
    sold_results = []
    results = DB.exec("SELECT * FROM albums WHERE sold = 't';")
    results.each do |sold_album|
      name = album.fetch("name")
      artist = album.fetch("artist")
      genre = album.fetch("genre")
      year = album.fetch("year").to_i
      sold = album.fetch("sold")
      id = album.fetch("id").to_i
      sold_results.push(Album.new({:name => name, :artist => artist, :genre => genre, :year => year, :sold => sold, :id => id}))
    end
    sold_results
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
    result = DB.exec("INSERT INTO albums (name, artist, genre, year, sold) VALUES ('#{@name}', '#{@artist}', '#{@genre}', #{@year}, '#{@sold}') RETURNING id;") # update
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    (self.name == album_to_compare.name) && (self.year == album_to_compare.year) && (self.genre == album_to_compare.genre) && (self.artist == album_to_compare.artist) && (self.sold == album_to_compare.sold)
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first # update
    name = album.fetch("name")
    artist = album.fetch("artist")
    genre = album.fetch("genre")
    year = album.fetch("year").to_i
    id = album.fetch("id").to_i
    sold = album.fetch("sold")
    Album.new({:name => name, :artist => artist, :genre => genre, :year => year, :sold => sold, :id => id})
  end

  # def self.find_sold(id)
  #   @@sold_albums[id]
  # end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:album_name)) && (attributes.fetch(:album_name) != nil)
      album_name = attributes.fetch(:album_name)
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  # def update(name) # update for all attributes
  #   @name = name
  #   DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  # end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  # def delete # update
  #   DB.exec("DELETE FROM albums WHERE id = #{@id};")
  #   DB.exec("DELETE FROM songs WHERE album_id = #{@id};") # new code
  # end

  # def self.sort
  #   array = @@albums.values.sort_by! &:name
  #   @@albums = {}
  #   array.each do |element|
  #     @@albums[element.id] = element
  #   end
  # end

  # def self.sort_sold
  #   array = @@sold_albums.values.sort_by! &:name
  #   @@sold_albums = {}
  #   array.each do |element|
  #     @@sold_albums[element.id] = element
  #   end
  # end

  def sold
    @sold = 't'
    DB.exec("UPDATE albums SET sold = 't' WHERE id = #{@id};")
  end

  def songs
    Song.find_by_album(self.id)
  end

  def albums
    albums = []
    results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
    results.each() do |result|
      album_id = result.fetch("album_id").to_i()
      album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
      name = album.first().fetch("name")
      albums.push(Album.new({:name => name, :id => album_id}))
    end
    albums
  end
end