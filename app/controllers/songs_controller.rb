class SongsController < ApplicationController

    get "/songs" do
        
        @songs = Song.all
# binding.pry
        erb :"/songs/index"
    end  

    get '/songs/new' do
        @genres=Genre.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        name = Slugifiable.unslug(params[:slug])
        @song = Song.find_by(name:name)
       
        erb :'/songs/show'
    end 

    get '/songs/:slug/edit' do
     @song = Song.find_by(name:Slugifiable.unslug(params[:slug]))
     @genres = Genre.all
    
        erb :"/songs/edit"
    end

    post '/songs' do
    
        artist = Artist.find_or_create_by(name:params[:song][:artist]) 
        @song = Song.create(name:params[:song][:name])
        @song.artist = artist
        @song.genres=[]
        params[:song][:genre_ids].each  do |genre_id|
            genre = Genre.find_by(id:genre_id.to_i)
            @song.genres << genre
        end
        # song.update(genres:params[:song][:genre_ids])
        @song.save
        slug = Slugifiable.slug(@song.name)
        redirect :"/songs/#{slug}"
    end 

    patch '/songs/:slug' do
        # binding.pry
        song = Song.find_by(name:Slugifiable.unslug(params[:slug]))
        song.update(name:params[:song][:name])
        artist = Artist.find_or_create_by(name:params[:song][:artist])
        # binding.pry
        song.artist = artist
        song.genres=[]
        params[:song][:genre_ids].each  do |genre_id|
            genre = Genre.find_by(id:genre_id.to_i)
            song.genres << genre
        end
        song.save
        slug = Slugifiable.slug(song.name)
        redirect :"/songs/#{slug}"
    end 

    
end 