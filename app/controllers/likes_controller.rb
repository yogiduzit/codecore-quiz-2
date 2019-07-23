class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    @like = Like.new(user_id: current_user.id, idea_id: params[:idea_id])
    @like.save!
    p @like
    redirect_to idea_path(@like.idea)
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    redirect_to idea_path(@like.idea)
  end

  private
  def authorize_user!
    @like = Like.find_by(id: params[:id])
    redirect_to home_page_path unless can?(:crud, @like)
  end
end
