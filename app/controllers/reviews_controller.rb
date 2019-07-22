class ReviewsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    review = Review.new review_params
    idea = Idea.find(params[:idea_id])

    review.idea = idea
    review.user = current_user
    review.save

    redirect_to idea_path(idea)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy

    redirect_to idea_path(review.idea)
  end

  private
  def review_params
    params.require(:review).permit(:body)
  end

  def authorize_user!
    @review = Review.find(params[:id])
    redirect_to home_page_path unless can?(:crud, @review)
  end
end
