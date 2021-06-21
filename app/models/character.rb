# TODO: SPECS
class Character < ApplicationRecord
  STATES = ["seeking_battle", "waiting_battle", "battling"].freeze
  include Stateful

  belongs_to :user
  # has_one :position, :as => :positionable, :dependent => :destroy

  has_many :occupations
  has_many :planets, :through => :occupations, :source => :occupiable, :source_type => 'Planet'
  has_many :stars, :through => :occupations, :source => :occupiable, :source_type => 'Star'
  has_many :stations, :through => :occupations, :source => :occupiable, :source_type => 'Station'
  has_many :asteroids, :through => :occupations, :source => :occupiable, :source_type => 'Asteroid'

  has_many :participations
  has_many :battles, :through => :participations, :source => :participatable, :source_type => 'Battle'
  # has_many :conversations, :through => :participations, :source => :participatable, :source_type => 'Conversation'

  has_many :ships

  # TODO: SPECS
  validates :name, :length => { :in => 2..12 }

  # after_commit :assign_station_position, :on => [:create]
  # TODO: SPECS
  # after_create :assign_station_position

  # def assign_station_position
  #   random_station_id = Station.pluck(:id).sample # TODO: make sure this is far from galaxe center !!
  #   station_position = Station.find(random_station_id).position
  #   Position.create!(:positionable => self, :x => station_position.x, :y => station_position.y)
  # end

  # after_create :assign_default_station_occupation
  # TODO: assign beginner ships !!
  after_create :assign_defaults

  def assign_defaults
    ActiveRecord::Base.transaction do
      assign_default_station_occupation
      assign_default_ships
    end
  end

  def assign_default_station_occupation
    # random_station_id = Station.pluck(:id).sample # TODO: make sure this is far from galaxe center !!
    # station_position = Station.find(random_station_id).position

    station = Station.beginner.first
    # Position.create!(:positionable => self, :x => station_position.x, :y => station_position.y)
    Occupation.create!(:character => self, :occupiable => station)
  end

  def assign_default_ships
    ship_category_counts = { :small => 6, :medium => 4, :large => 2}
    ships = FleetGenerator.call(ship_category_counts)
    update!(:ships => ships)
  end

  def active_battle_set_ships
    ships.battle_set(active_battle_set)
  end
end
