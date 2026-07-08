class CalendarsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rallies = Rally.order(start_date: :asc)
  end
end
