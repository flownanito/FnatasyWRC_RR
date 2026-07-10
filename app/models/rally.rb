class Rally < ApplicationRecord
  enum surface: { gravel: 0, tarmac: 1, snow: 2 }
  enum status: { upcoming: 0, ongoing: 1, finished: 2 }
  
  has_many :stages
  has_many :official_driver_results
  has_many :fantasy_lineups

  def coordinates
    case country
    when 'Monaco' then { lat: 43.7384, lon: 7.4246 }
    when 'Sweden' then { lat: 63.8258, lon: 20.2630 } # Umeå
    when 'Kenya' then { lat: -0.7172, lon: 36.4310 } # Naivasha
    when 'Croatia' then { lat: 45.8150, lon: 15.9819 } # Zagreb
    when 'Spain' then { lat: 28.1235, lon: -15.4363 } # Las Palmas
    when 'Portugal' then { lat: 41.1496, lon: -8.6110 } # Porto / Matosinhos
    when 'Japan' then { lat: 35.0830, lon: 137.1562 } # Toyota City
    when 'Greece' then { lat: 38.8950, lon: 22.4333 } # Lamia
    when 'Estonia' then { lat: 58.3780, lon: 26.7290 } # Tartu
    when 'Finland' then { lat: 62.2415, lon: 25.7209 } # Jyväskylä
    when 'Paraguay' then { lat: -27.3306, lon: -55.8667 } # Encarnación
    when 'Chile' then { lat: -36.8201, lon: -73.0444 } # Concepción
    when 'Italy' then { lat: 40.5492, lon: 8.3129 } # Alghero
    when 'Saudi Arabia' then { lat: 21.4858, lon: 39.1925 } # Jeddah
    else { lat: 0.0, lon: 0.0 }
    end
  end
end
