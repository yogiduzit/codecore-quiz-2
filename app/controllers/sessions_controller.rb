class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_page_path
    else
      flash[:error] = "Username or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_page_path
  end
end
