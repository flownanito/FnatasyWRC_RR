class MarketsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.leagues.any?
      redirect_to market_league_path(current_user.leagues.first)
    else
      redirect_to leagues_path, alert: "Debes unirte o crear una Liga para acceder al Mercado de Fichajes."
    end
  end
end
