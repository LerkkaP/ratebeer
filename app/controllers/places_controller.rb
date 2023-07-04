class PlacesController < ApplicationController
  def index
  end

  def show
    @city = session[:city]
    @place_id = params[:id]
    cache_key = "place_#{@city}_#{@place_id}"
    @place = Rails.cache.fetch(cache_key) do
      places = BeermappingApi.places_in(@city)
      place = places.find { |p| p['id'] == @place_id }
      place || nil
    end
    redirect_to places_path, notice: "Place not found" if @place.nil?
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end
end
