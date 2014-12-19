class UsersController < ApplicationController
  include ActionController::Live
  before_filter :only_myself, only: [:edit, :update]

  def index
    @users = User.without_user(current_user)
  end

  def status
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render :json =>  @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user])
    redirect_to users_path
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    response.stream.write ""
  end

  private
  def user_params 
    params.require(:user).permit(:status, :first_name, :last_name)
  end
  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
