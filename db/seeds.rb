puts "Cleaning DB..."
FantasyLineup.destroy_all
LeagueMember.destroy_all
League.destroy_all
OfficialDriverResult.destroy_all
Stage.destroy_all
User.destroy_all
Driver.destroy_all
Car.destroy_all
Team.destroy_all
Engineer.destroy_all
Sponsor.destroy_all
Rally.destroy_all

puts "Creating Admin User..."
User.create!(email: 'admin@fantasywrc.com', password: 'password', username: 'admin', points: 0, budget: 100_000_000.0)

puts "Creating Teams..."
tgr = Team.create!(name: 'Toyota Gazoo Racing WRT', logo: 'https://www.carlogos.org/logo/Toyota-logo.png')
hsm = Team.create!(name: 'Hyundai Shell Mobis WRT', logo: 'https://www.carlogos.org/logo/Hyundai-logo.png')
msport = Team.create!(name: 'M-Sport Ford WRT', logo: 'https://www.carlogos.org/logo/Ford-logo.png')

puts "Creating Drivers..."
drivers_data = [
  # TOYOTA GAZOO RACING
  { name: 'Sébastien Ogier', team: tgr, category: :rally1, participation: :part_time, price: 32_000_000.0, overall_rating: 97, pace: 98, consistency: 96, experience: 99, image_url: 'drivers/bastien-ogier.webp' },
  { name: 'Elfyn Evans', team: tgr, category: :rally1, participation: :full_time, price: 28_000_000.0, overall_rating: 93, pace: 93, consistency: 95, experience: 92, image_url: 'drivers/elfyn-evans.webp' },
  { name: 'Takamoto Katsuta', team: tgr, category: :rally1, participation: :part_time, price: 16_000_000.0, overall_rating: 83, pace: 87, consistency: 78, experience: 84, image_url: 'drivers/takamoto-katsuta.webp' },
  { name: 'Sami Pajari', team: tgr, category: :rally1, participation: :full_time, price: 13_000_000.0, overall_rating: 80, pace: 86, consistency: 82, experience: 65, image_url: 'drivers/sami-pajari.webp' },
  
  # HYUNDAI MOTORSPORT
  { name: 'Thierry Neuville', team: hsm, category: :rally1, participation: :full_time, price: 30_000_000.0, overall_rating: 94, pace: 96, consistency: 92, experience: 96, image_url: 'drivers/thierry-neuville.webp' },
  { name: 'Dani Sordo', team: hsm, category: :rally1, participation: :part_time, price: 20_000_000.0, overall_rating: 88, pace: 84, consistency: 95, experience: 98, image_url: 'drivers/dani-sordo.webp' },
  { name: 'Adrien Fourmaux', team: hsm, category: :rally1, participation: :full_time, price: 22_000_000.0, overall_rating: 88, pace: 89, consistency: 90, experience: 75, image_url: 'drivers/adrien-fourmaux.webp' },
  { name: 'Esapekka Lappi', team: hsm, category: :rally1, participation: :part_time, price: 18_000_000.0, overall_rating: 86, pace: 91, consistency: 80, experience: 88, image_url: 'drivers/esapekka-lappi.webp' },
  { name: 'Hayden Paddon', team: hsm, category: :rally1, participation: :part_time, price: 17_000_000.0, overall_rating: 86, pace: 85, consistency: 88, experience: 86, image_url: 'drivers/hayden-paddon.webp' },

  # M-SPORT FORD
  { name: 'Joshua McErlean', team: msport, category: :rally1, participation: :full_time, price: 9_000_000.0, overall_rating: 75, pace: 78, consistency: 75, experience: 60, image_url: 'drivers/joshua-mcerlean.webp' }
]

drivers_data.each do |data|
  Driver.create!(data)
end

puts "Creating Cars..."
Car.create!([
  { name: 'Toyota GR Yaris Rally1', team: tgr, price: 20_000_000.0, performance_bonus: 5 },
  { name: 'Hyundai i20 N Rally1', team: hsm, price: 19_000_000.0, performance_bonus: 4 },
  { name: 'Ford Puma Rally1', team: msport, price: 16_000_000.0, performance_bonus: 2 }
])

puts "Creating Engineers..."
Engineer.create!([
  { name: 'Tom Fowler', specialty: :engine, price: 5_000_000.0, bonus_multiplier: 1.1 },
  { name: 'Christian Loriaux', specialty: :aero, price: 4_500_000.0, bonus_multiplier: 1.08 }
])

puts "Creating Sponsors..."
Sponsor.create!([
  { name: 'Red Bull', monetary_reward: 2_000_000.0, condition: 'Top 5 finish' },
  { name: 'Pirelli', monetary_reward: 1_000_000.0, condition: 'Complete without punctures' },
  { name: 'Monster Energy', monetary_reward: 1_500_000.0, condition: 'Win Power Stage' }
])

puts "Creating Rallies..."
Rally.create!([
  { name: 'Rallye Monte-Carlo', country: 'Monaco', surface: :tarmac, status: :finished, start_date: '2026-01-22', end_date: '2026-01-25' },
  { name: 'Rally Sweden', country: 'Sweden', surface: :snow, status: :finished, start_date: '2026-02-12', end_date: '2026-02-15' },
  { name: 'Safari Rally Kenya', country: 'Kenya', surface: :gravel, status: :finished, start_date: '2026-03-12', end_date: '2026-03-15' },
  { name: 'Croatia Rally', country: 'Croatia', surface: :tarmac, status: :finished, start_date: '2026-04-09', end_date: '2026-04-12' },
  { name: 'Rally Islas Canarias', country: 'Spain', surface: :tarmac, status: :finished, start_date: '2026-04-23', end_date: '2026-04-26' },
  { name: 'Rally de Portugal', country: 'Portugal', surface: :gravel, status: :finished, start_date: '2026-05-07', end_date: '2026-05-10' },
  { name: 'Rally Japan', country: 'Japan', surface: :tarmac, status: :finished, start_date: '2026-05-28', end_date: '2026-05-31' },
  { name: 'Acropolis Rally Greece', country: 'Greece', surface: :gravel, status: :finished, start_date: '2026-06-25', end_date: '2026-06-28' },
  { name: 'Rally Estonia', country: 'Estonia', surface: :gravel, status: :ongoing, start_date: '2026-07-16', end_date: '2026-07-19' },
  { name: 'Rally Finland', country: 'Finland', surface: :gravel, status: :upcoming, start_date: '2026-07-30', end_date: '2026-08-02' },
  { name: 'Rally del Paraguay', country: 'Paraguay', surface: :gravel, status: :upcoming, start_date: '2026-08-27', end_date: '2026-08-30' },
  { name: 'Rally Chile', country: 'Chile', surface: :gravel, status: :upcoming, start_date: '2026-09-10', end_date: '2026-09-13' },
  { name: 'Rally Italia Sardegna', country: 'Italy', surface: :gravel, status: :upcoming, start_date: '2026-10-01', end_date: '2026-10-04' },
  { name: 'Rally Saudi Arabia', country: 'Saudi Arabia', surface: :gravel, status: :upcoming, start_date: '2026-11-11', end_date: '2026-11-14' }
])

puts "Done!"
