class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :league_members, dependent: :destroy
  has_many :leagues, through: :league_members
  has_one_attached :avatar
  has_many :owned_leagues, class_name: "League", foreign_key: "owner_id"
  has_many :fantasy_lineups
  has_many :league_drivers
end
