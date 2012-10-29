class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end
  
  def index
    @movies = Movie.paginate(page: params[:page], per_page: 45)
  end
end
