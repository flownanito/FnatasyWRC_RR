class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to teams_path, notice: "¡Escudería creada con éxito!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :logo)
  end
end
