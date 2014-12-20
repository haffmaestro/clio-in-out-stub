class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new

  end

  def show
    @team = Team.find params[:id]

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
      redirect_to teams_path, notice: "Team destroyed"
    else
      flash.now[:alert] = "Please correct errors below"
      render :show
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
end
