class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @leagues = @user.leagues
    @current_rally = Rally.ongoing.first || Rally.upcoming.first
    if @current_rally
      @lineup = @user.fantasy_lineups.find_by(rally: @current_rally)
    end
  end
end
