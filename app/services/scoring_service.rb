class ScoringService
  # Puntuaciones oficiales FIA WRC para los 10 primeros
  POINTS = [25, 18, 15, 12, 10, 8, 6, 4, 2, 1].freeze
  # Premios económicos por hacer podio
  PRIZES = [3_000_000.0, 2_000_000.0, 1_000_000.0].freeze
  
  # Puntuaciones Power Stage (Top 5)
  POWER_STAGE_POINTS = [5, 4, 3, 2, 1].freeze
  # Bonus económico Power Stage (Solo ganador)
  POWER_STAGE_BONUS = 500_000.0

  def self.calculate_for_rally(rally)
    results = rally.official_driver_results.order(:position)

    League.find_each do |league|
      results.each_with_index do |result, index|
        points = POINTS[index] || 0
        prize = PRIZES[index] || 0

        # Calcular bonus de Power Stage si tiene posición registrada (1 a 5)
        if result.power_stage_position && result.power_stage_position.between?(1, 5)
          points += POWER_STAGE_POINTS[result.power_stage_position - 1]
          prize += POWER_STAGE_BONUS if result.power_stage_position == 1
        end

        next if points == 0 && prize == 0

        league_driver = league.league_drivers.find_by(driver_id: result.driver_id)
        
        # Si el piloto tiene dueño en esta liga, sumar puntos y premio
        if league_driver && league_driver.user_id
          member = league.league_members.find_by(user_id: league_driver.user_id)
          if member
            member.update!(
              total_points: (member.total_points || 0) + points,
              budget: (member.budget || 0) + prize
            )
          end
        end
      end
    end
  end
end
