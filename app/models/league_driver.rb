class LeagueDriver < ApplicationRecord
  belongs_to :league
  belongs_to :driver
  belongs_to :user, optional: true

  class TransactionError < StandardError; end

  def buy_by!(purchasing_user)
    member = league.league_members.find_by!(user_id: purchasing_user.id)
    
    raise TransactionError, "Este piloto ya tiene dueño." if user_id.present?
    raise TransactionError, "Ya tienes el máximo de 2 pilotos en tu equipo." if league.league_drivers.where(user_id: purchasing_user.id).count >= 2
    
    cost = driver.price
    raise TransactionError, "No tienes presupuesto suficiente." if member.budget < cost
    
    transaction do
      member.update!(budget: member.budget - cost)
      update!(user_id: purchasing_user.id, release_clause: cost * 1.5)
    end
  end

  def buyout_by!(purchasing_user)
    member = league.league_members.find_by!(user_id: purchasing_user.id)
    
    raise TransactionError, "Piloto inválido para clausulazo." if user_id.nil? || user_id == purchasing_user.id
    raise TransactionError, "Ya tienes el máximo de 2 pilotos en tu equipo." if league.league_drivers.where(user_id: purchasing_user.id).count >= 2
    
    cost = release_clause || (driver.price * 1.5)
    raise TransactionError, "No tienes presupuesto suficiente." if member.budget < cost
    
    transaction do
      member.update!(budget: member.budget - cost)
      
      old_owner_member = league.league_members.find_by(user_id: user_id)
      old_owner_member.update!(budget: old_owner_member.budget + cost) if old_owner_member
      
      update!(user_id: purchasing_user.id, release_clause: cost * 1.5)
    end
  end

  def sell_by!(selling_user)
    member = league.league_members.find_by!(user_id: selling_user.id)
    
    raise TransactionError, "Este piloto no es tuyo." if user_id != selling_user.id
    
    recovery_amount = (driver.price * 0.8).to_i
    
    transaction do
      member.update!(budget: member.budget + recovery_amount)
      update!(user_id: nil, release_clause: nil)
    end
    
    recovery_amount
  end
end
