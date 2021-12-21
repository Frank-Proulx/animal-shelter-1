require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')
require 'pg'

DB = PG.connect({:dbname => "record_store"})

get('/') do
  @albums = Album.all
  erb(:albums)
end

get ('/artists') do 
  @artists = Artist.all
  erb(:artists)
end

get('/albums') do
  @albums = Album.all
  erb(:albums) # not sure if i was supposed to delete this?
end

get('/albums/sort') do
  Album.sort
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end
get('/artists/new') do
  erb(:new_artist)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @albums = []
  erb(:artist)
end

post('/albums') do
  name = params[:album_name]
  genre = params[:album_genre]
  year = params[:album_year]
  album = Album.new(:name => name, :genre => genre, :year => year, :id => nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

post('/artists') do
  name = params[:artist_name]
  artist = Artist.new(:name => name, :id => nil)
  artist.save()
  @artists = Artist.all()
  erb(:artists)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

get('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  erb(:edit_artist)
end

patch('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:album_name => params[:album_name]})
  @albums = @artist.albums
  erb(:artist)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name], params[:genre], params[:year])
  @albums = Album.all
  erb(:albums)
end

patch('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:name => params[:name]})
  @artist = Artist.all
  redirect back
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

delete('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  @artists = Artist.all
  erb(:artists)
end

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(:name => params[:song_name], :album_id => @album.id, :id => nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end