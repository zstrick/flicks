class ReviewsController < ApplicationController
  before_action :set_event
  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

  private

    def review_params
      params.require(:review).permit(:name, :stars, :comment)
    end

    def set_event
      @movie = Movie.find(params[:movie_id])
    end
end
