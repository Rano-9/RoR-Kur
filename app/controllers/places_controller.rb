class PlacesController < ApplicationController
  def index
  end

  def search

    @places = BeermappingApi.places_in(params[:city])
    session[:last_search] = params[:city]

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end

  def show
    if params[:id]
      last_search = session[:last_search]
      places = Rails.cache.read(last_search)
      @place = Place.new(places.select { |place| place.id == params[:id] }.first)
    end
  end

end