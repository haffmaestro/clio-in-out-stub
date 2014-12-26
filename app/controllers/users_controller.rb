class UsersController < ApplicationController
  include ActionController::Live
  before_filter :only_myself, only: [:edit, :update]

  def index
    @users = User.without_user(current_user)
    respond_to do |format|
      format.html {@users}
      format.json {render json: @users, each_serializer: UserSerializer}
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    response.headers["Content-Type"] = "text/javascript"
    user = User.find(params[:id])
    user.update_attributes(user_params)
    if user.status == :in
      $redis.publish('users.in', {userId: user.id}.to_json)
    else
      $redis.publish('users.out', {userId: user.id}.to_json)
    end
    redirect_to users_path
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('users.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

  private
  
  def user_params 
    params.require(:user).permit(:status,:email, :first_name, :last_name, :web_site, :id )
  end

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
