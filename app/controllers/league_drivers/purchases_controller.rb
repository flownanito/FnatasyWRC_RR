class LeagueDrivers::PurchasesController < ApplicationController
  before_action :authenticate_user!

  def create
    @league_driver = LeagueDriver.find(params[:league_driver_id])
    @league = @league_driver.league

    begin
      @league_driver.buy_by!(current_user)
      redirect_to market_league_path(@league), notice: "Has fichado a #{@league_driver.driver.name}."
    rescue LeagueDriver::TransactionError => e
      redirect_to market_league_path(@league), alert: e.message
    end
  end
end
