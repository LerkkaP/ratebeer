class StylesController < ApplicationController
  before_action :ensure_admin, only: [:destroy]

  def index
    @styles = Style.all
  end

  def show
    @style = Style.find(params[:id])
    @beers = Beer.where(style_id: @style.id)
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new(style_params)
    if @style.save
      redirect_to styles_path, notice: "Style created successfully."
    else
      render :new
    end
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])
    if @style.update(style_params)
      redirect_to styles_path, notice: "Style updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @style = Style.find(params[:id])
    @style.beers.destroy_all
    @style.destroy
    redirect_to styles_path, notice: "Style deleted successfully."
  end

  private

  def ensure_admin
    return if current_user&.admin?

    redirect_to root_path, notice: "Only admins can perform this action."
  end

  def style_params
    params.require(:style).permit(:name, :description)
  end
end
