class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:home, :index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  def home
  end

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all
  end

  def show
   @idea = find_idea
  end

  def create
    @idea = Idea.new idea_params

    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def edit
    @idea = find_idea
  end

  def update
    @idea = find_idea

    if @idea.update(idea_params)
      redirect_to(idea_path(@idea))
    else
      render :edit
    end
  end

  def destroy
    @idea = find_idea
    @idea.destroy
    redirect_to(ideas_path)
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :body, :user_id)
  end

  def find_idea
    Idea.find(params[:id])
  end

  def authorize_user!
    @idea = find_idea
    redirect_to home_page_path unless can?(:crud, @idea)
  end
end
