require 'net/http'
require 'json'

class WeatherService
  # Returns the weather forecast for the next 14 days, grouped by date.
  # If the rally is > 14 days away from today, returns nil.
  def self.forecast(rally)
    return nil unless rally.start_date
    
    today = Date.current
    days_until_start = (rally.start_date - today).to_i
    days_since_end = rally.end_date ? (today - rally.end_date).to_i : 0
    
    # Return nil if the rally is > 14 days away, or ended > 14 days ago.
    return nil if days_until_start > 14 || days_since_end > 14

    coords = rally.coordinates
    return nil if coords[:lat] == 0.0

    cache_key = "weather_forecast_#{rally.id}"
    
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      fetch_from_api(coords[:lat], coords[:lon])
    end
  end

  private

  def self.fetch_from_api(lat, lon)
    url = URI("https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto&forecast_days=16&past_days=14")
    
    response = Net::HTTP.get_response(url)
    return nil unless response.is_a?(Net::HTTPSuccess)
    
    data = JSON.parse(response.body)
    daily = data['daily']
    
    return nil unless daily

    forecast_by_date = {}
    
    daily['time'].each_with_index do |date_str, index|
      code = daily['weather_code'][index]
      weather_data = map_weather_code(code)
      
      forecast_by_date[date_str] = {
        weather: weather_data[:text],
        icon: weather_data[:icon],
        temp_max: daily['temperature_2m_max'][index],
        temp_min: daily['temperature_2m_min'][index],
        precip_prob: daily['precipitation_probability_max'][index]
      }
    end

    forecast_by_date
  rescue StandardError => e
    Rails.logger.error("Weather API error: #{e.message}")
    nil
  end

  def self.map_weather_code(code)
    case code
    when 0
      { text: 'Despejado', icon: '☀️' }
    when 1, 2, 3
      { text: 'Nublado', icon: '☁️' }
    when 45, 48
      { text: 'Niebla', icon: '🌫️' }
    when 51, 53, 55, 56, 57
      { text: 'Llovizna', icon: '🌦️' }
    when 61, 63, 65, 66, 67
      { text: 'Lluvia', icon: '🌧️' }
    when 71, 73, 75, 77
      { text: 'Nieve', icon: '❄️' }
    when 80, 81, 82
      { text: 'Chubascos', icon: '🌧️' }
    when 85, 86
      { text: 'Tormenta Nieve', icon: '❄️' }
    when 95, 96, 99
      { text: 'Tormenta', icon: '⛈️' }
    else
      { text: 'Despejado', icon: '☀️' }
    end
  end
end
