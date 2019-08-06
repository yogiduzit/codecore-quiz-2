class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    @like = Like.new(user: current_user, idea_id: params[:idea_id])
    @idea = Idea.find(params[:idea_id])
    
    if !can?(:like, @idea)
      flash[:error] = "Cannot like your own idea"
      redirect_to idea_path(@idea)
    else
      @like.save
      redirect_to idea_path(@like.idea)
    end

  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    redirect_to idea_path(@like.idea)
  end

  private
  def authorize_user!
    @like = Like.find_by(id: params[:id])
    redirect_to idea_path(@like.idea) unless can?(:like, @like.idea)
  end
end
