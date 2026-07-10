class RalliesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @rally = Rally.find(params[:id])
  end
end
