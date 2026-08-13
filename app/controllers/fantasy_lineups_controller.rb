class FantasyLineupsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_league

  def new
    @rally = params[:rally_id] ? Rally.find(params[:rally_id]) : (Rally.ongoing.first || Rally.upcoming.first)
    
    if current_user.fantasy_lineups.exists?(rally: @rally, league: @league)
      return redirect_to league_path(@league), alert: "Ya has configurado tu setup para este rally."
    end

    @lineup = FantasyLineup.new(rally: @rally, league: @league)
    @member = @league.league_members.find_by(user_id: current_user.id)
    load_entities
  end

  def create
    @lineup = current_user.fantasy_lineups.build(lineup_params)
    @lineup.league = @league
    @rally = Rally.find(lineup_params[:rally_id])

    @member = @league.league_members.find_by(user_id: current_user.id)

    if @lineup.save
      @member.update!(budget: @member.budget - @lineup.calculate_cost)
      redirect_to league_path(@league), notice: "¡Setup configurado con éxito!"
    else
      load_entities
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return redirect_to league_path(@league), alert: "No puedes editar el setup una vez confirmado."
  end

  def update
    return redirect_to league_path(@league), alert: "No puedes editar el setup una vez confirmado."
  end

  private

  def set_league
    @league = League.find(params[:league_id])
  end

  def load_entities
    @cars = Car.all
    @engineers = Engineer.all
    @sponsors = Sponsor.all
  end

  def lineup_params
    params.require(:fantasy_lineup).permit(:rally_id, :car_id, :engineer_id, :sponsor_id)
  end
end
