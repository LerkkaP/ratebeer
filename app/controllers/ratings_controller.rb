class RatingsController < ApplicationController
  def index
    @top_beers = Beer.top_by_average_rating(3)
    @top_breweries = Brewery.top_by_average_rating(3)
    @top_styles = Style.top_by_average_rating(3)
    @top_users = User.joins(:ratings).group(:id).order('COUNT(ratings.id) DESC').limit(3)
    @recent_ratings = Rating.recent
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

  # def create
  # raise
  # end
end
