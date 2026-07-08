class LeagueDriversController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league_driver

  def buy
    @league = @league_driver.league
    @member = @league.league_members.find_by(user_id: current_user.id)
    
    unless @member
      return redirect_to league_path(@league), alert: "No perteneces a esta liga."
    end
    
    if @league_driver.user_id.present?
      return redirect_to market_league_path(@league), alert: "Este piloto ya tiene dueño."
    end

    # Restricción: máximo 2 pilotos
    if @league.league_drivers.where(user_id: current_user.id).count >= 2
      return redirect_to market_league_path(@league), alert: "Ya tienes el máximo de 2 pilotos en tu equipo."
    end
    
    cost = @league_driver.driver.price
    if @member.budget < cost
      return redirect_to market_league_path(@league), alert: "No tienes presupuesto suficiente."
    end
    
    ActiveRecord::Base.transaction do
      @member.update!(budget: @member.budget - cost)
      # Cláusula por defecto: 150% del coste
      @league_driver.update!(user_id: current_user.id, release_clause: cost * 1.5)
    end
    
    redirect_to market_league_path(@league), notice: "Has fichado a #{@league_driver.driver.name}."
  end

  def clausulazo
    @league = @league_driver.league
    @member = @league.league_members.find_by(user_id: current_user.id)
    
    unless @member
      return redirect_to league_path(@league), alert: "No perteneces a esta liga."
    end
    
    if @league_driver.user_id.nil? || @league_driver.user_id == current_user.id
      return redirect_to market_league_path(@league), alert: "Piloto inválido para clausulazo."
    end

    # Restricción: máximo 2 pilotos
    if @league.league_drivers.where(user_id: current_user.id).count >= 2
      return redirect_to market_league_path(@league), alert: "Ya tienes el máximo de 2 pilotos en tu equipo."
    end
    
    cost = @league_driver.release_clause || @league_driver.driver.price * 1.5
    if @member.budget < cost
      return redirect_to market_league_path(@league), alert: "No tienes presupuesto suficiente."
    end
    
    ActiveRecord::Base.transaction do
      # Restar al comprador
      @member.update!(budget: @member.budget - cost)
      
      # Sumar al dueño anterior
      old_owner_member = @league.league_members.find_by(user_id: @league_driver.user_id)
      old_owner_member.update!(budget: old_owner_member.budget + cost) if old_owner_member
      
      # Transferir piloto y subir clausula un 150%
      @league_driver.update!(user_id: current_user.id, release_clause: cost * 1.5)
    end
    
    redirect_to market_league_path(@league), notice: "¡Clausulazo! Has robado a #{@league_driver.driver.name}."
  end

  def sell
    @league = @league_driver.league
    @member = @league.league_members.find_by(user_id: current_user.id)
    
    unless @member
      return redirect_to league_path(@league), alert: "No perteneces a esta liga."
    end
    
    if @league_driver.user_id != current_user.id
      return redirect_to market_league_path(@league), alert: "Este piloto no es tuyo."
    end
    
    # Recupera el 80% del valor inicial de mercado del piloto por venta debido a rescisión de contrato temporal
    recovery_amount = (@league_driver.driver.price * 0.8).to_i
    
    ActiveRecord::Base.transaction do
      @member.update!(budget: @member.budget + recovery_amount)
      @league_driver.update!(user_id: nil, release_clause: nil)
    end
    
    redirect_to market_league_path(@league), notice: "Has vendido a #{@league_driver.driver.name} por #{ActionController::Base.helpers.number_to_currency(recovery_amount, unit: '€', precision: 0)}."
  end

  private

  def set_league_driver
    @league_driver = LeagueDriver.find(params[:id])
  end
end
