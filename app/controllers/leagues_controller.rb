class LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
    @members = @league.league_members.includes(:user).order(total_points: :desc)
    @current_member = @league.league_members.find_by(user_id: current_user.id)
    
    @current_rally = Rally.ongoing.first || Rally.upcoming.first
    if @current_rally
      @lineup = @league.fantasy_lineups.find_by(user_id: current_user.id, rally_id: @current_rally.id)
      @my_drivers = @league.league_drivers.where(user_id: current_user.id).map(&:driver)
    end
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.owner_id = current_user.id

    if @league.save
      LeagueMember.create!(user: current_user, league: @league, total_points: 0)
      redirect_to dashboard_league_path(@league), notice: "SYSTEM: League initialized successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def join
    @league = League.find_by(code: params[:code])
    
    if @league
      if @league.users.include?(current_user)
        redirect_to dashboard_league_path(@league), alert: "Ya estás en esta liga."
      elsif @league.users.count >= 5
        redirect_to leagues_path, alert: "Esta liga ya está llena (máximo 5 jugadores)."
      else
        LeagueMember.create!(user: current_user, league: @league, total_points: 0)
        redirect_to dashboard_league_path(@league), notice: "¡Te has unido a la liga con éxito!"
      end
    else
      redirect_to leagues_path, alert: "Código de liga inválido."
    end
  end

  def dashboard
    @league = League.find(params[:id])
    @member = @league.league_members.find_by(user_id: current_user.id)
    
    unless @member
      return redirect_to leagues_path, alert: "No perteneces a esta liga."
    end
    
    @current_rally = Rally.ongoing.first || Rally.upcoming.first
    if @current_rally
      @lineup = @league.fantasy_lineups.find_by(user_id: current_user.id, rally_id: @current_rally.id)
    end
    
    @my_drivers = @league.league_drivers.where(user_id: current_user.id).includes(:driver)
    @team_value = @my_drivers.sum { |ld| ld.driver.price }
    @total_budget = @member.budget
  end

  def market
    @league = League.find(params[:id])
    @member = @league.league_members.find_by(user_id: current_user.id)
    
    unless @member
      return redirect_to leagues_path, alert: "No perteneces a esta liga."
    end
    
    @league_drivers = @league.league_drivers.includes(:driver, :user).sort_by { |ld| ld.driver.price }.reverse
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
