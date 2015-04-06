class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :delete, :update]

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
    flash[:notice] = " new team created";
    redirect_to(:action=>"index", :id=>@parent.id)
  end

  def child
    @parent = Team.find params[:id]
    @team = Team.new
  end

  def edit
    @team = Team.find params[:id]
  end

  def update
    @team.update_attributes(team_params)
    flash[:notice] = "team updated";
    redirect_to(:action=>"show", :id=>@team.id)
  end

  def delete
    begin
      @team.destroy
      flash[:notice] = "team deleted"
    rescue Exception=>e
      flash[:notice] = e.message;
    end
  end


  private 
    def team_params
      params.require(:team).permit(:name)
    end

    def set_team
      @team = Team.find params[:id]
    end
end
