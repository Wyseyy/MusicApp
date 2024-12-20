class SongsController < ApplicationController
  before_action :set_song, only: %i[show update destroy favorite]

  # GET /songs
  def index
    songs = Song.all
    render json: songs
  end

  # GET /songs/:id
  def show
    render json: @song
  end

  # POST /songs
  def create
    song = Song.new(song_params)

    if song.save
      render json: song, status: :created
    else
      render json: { errors: song.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/:id
  def update
    if @song.update(song_params)
      render json: @song, status: :ok
    else
      render json: { errors: @song.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /songs/:id
  def destroy
    if @song.destroy
      render json: { message: 'Song successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete song' }, status: :unprocessable_entity
    end
  end

  # PATCH /songs/:id/favorite
  def favorite
    @song.is_favorite = !@song.is_favorite

    if @song.save
      message = @song.is_favorite ? 'Song has been added to favorites!' : 'Song has been removed from favorites'
      render json: { message: message, song: @song }, status: :ok
    else
      render json: { error: 'Failed to update favorite status' }, status: :unprocessable_entity
    end
  end

  private

  # Find song by ID
  def set_song
    @song = Song.find_by(id: params[:id])
    render json: { error: 'Song not found' }, status: :not_found unless @song
  end

  # Permit song parameters
  def song_params
    params.require(:song).permit(:title, :artist, :album, :year, :is_favorite)
  end
end
