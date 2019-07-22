class IdeasController < ApplicationController
  def home
  end

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all
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
    params.require(:idea).permit(:title, :body)
  end

  def find_idea
    Idea.find(params[:id])
  end
end
