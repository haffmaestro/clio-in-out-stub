class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new

  end

  def show
    @team = Team.find params[:id]
    respond_to do |format|
      format.html {@team}
      format.json {render json: @team}
    end

  end

  def create
    team = Team.new team_params
    if team.save
      redirect_to team, notice: "Team created!"
    else
      flash.now[:alert] = "Please correct errors below"
      render :new
    end
  end

  def edit
    @team = Team.find params[:id]

  end

  def update
    @team = Team.find params[:id]
    @team.update_params team_params
    if @team.save
      redirect_to @team, notice: "Team updated!"
    else
      flash.now[:alert] = "Please correct errors below"
      render :edit
    end
  end

  def destroy
    @team = Team.find params[:id]
    if @team.destroy
      redirect_to teams_path, notice: "Team deleted"
    else
      flash.now[:alert] = "Please correct errors below"
      render :show
    end
  end

  def add_user
    user = User.find params[:user][:id]
    user.team = Team.find params[:id]
    if user.save
      render json: {saved: true}
    else
      render json: {saved: false}
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end
