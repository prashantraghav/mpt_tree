class TeamsController < ApplicationController
  def index
    @team = (params[:id]) ? Team.find(params[:id]) : Team.first
  end

  def show
    @team = Team.find params[:id]
  end

  def create
    @parent = Team.find(params[:id])
    @team = Team.create(team_params)
    @parent << @team
    redirect_to(:action=>"index", :id=>@parent.id)
  end

  def child
    @parent = Team.find params[:id]
    @team = Team.new
  end

  def edit
    @team = Team.find params[:id]
  end

  def delete
    @team = Team.find params[:id]
  end


  private 
    def team_params
      params.require(:team).permit(:name)
    end
end
