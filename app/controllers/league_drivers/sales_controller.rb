class LeagueDrivers::SalesController < ApplicationController
  before_action :authenticate_user!

  def create
    @league_driver = LeagueDriver.find(params[:league_driver_id])
    @league = @league_driver.league

    begin
      recovery_amount = @league_driver.sell_by!(current_user)
      redirect_to market_league_path(@league), notice: "Has vendido a #{@league_driver.driver.name} por #{ActionController::Base.helpers.number_to_currency(recovery_amount, unit: '€', precision: 0)}."
    rescue LeagueDriver::TransactionError => e
      redirect_to market_league_path(@league), alert: e.message
    end
  end
end
