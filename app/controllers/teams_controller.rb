class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end

  def new
    @team = Team.all

  end

  def show

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
