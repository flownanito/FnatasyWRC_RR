class ApplicationController < ActionController::Base
  before_action :set_locale

  helper_method :current_league

  private

  def current_league
    return @current_league if defined?(@current_league)
    return nil unless user_signed_in?

    if params[:league_id]
      @current_league = current_user.leagues.find_by(id: params[:league_id])
    elsif params[:controller] == 'leagues' && params[:id] && params[:action] != 'join'
      @current_league = current_user.leagues.find_by(id: params[:id])
    elsif session[:current_league_id]
      @current_league = current_user.leagues.find_by(id: session[:current_league_id])
    end

    session[:current_league_id] = @current_league.id if @current_league
    @current_league
  end

  def set_locale
    if user_signed_in? && current_user.respond_to?(:locale)
      I18n.locale = current_user.locale || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end
end
