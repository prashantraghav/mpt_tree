class TeamsController < ApplicationController
  before_action :root_entry, :only=>[:index]
  before_action :set_team, :only=>[:edit, :update, :destroy, :show]

  def index
    parent = Team.root 
    @teams = parent.children
  end

  def show
    @parent = Team.find(params[:id])
    @teams = @parent.children
  end

  def new
    @team = Team.new
    @parent_id = params[:parent_id]
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team.save
    parent_team << @team
    redirect_to team_path(@team), notice: 'Team was successfully created.' 
  end

  def update
    @team.update(team_params)
    redirect_to team_path(@team), notice: 'Team was successfully updated.' 
  end

  def destroy
  end

  private 
  def set_team
    @team = Team.find params[:id]
  end

  def team_params 
        
    params.require(:team).permit(:title)
  end

  def parent_team
    parent_team_id = (params.require(:team).permit(:parent_id)[:parent_id])
    team = (parent_team_id.empty?) ? Team.root : Team.find(parent_team_id)
  end

  def root_entry 
    Team.create(:title=>'root').make_it_root if !Team.first
  end
end
