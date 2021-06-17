# TODO: SPECS
class Character < ApplicationRecord
  belongs_to :user
  # has_one :position, :as => :positionable, :dependent => :destroy

  has_many :occupations
  has_many :planets, :through => :occupations, :source => :occupiable, :source_type => 'Planet'
  has_many :stars, :through => :occupations, :source => :occupiable, :source_type => 'Star'
  has_many :stations, :through => :occupations, :source => :occupiable, :source_type => 'Station'
  has_many :asteroids, :through => :occupations, :source => :occupiable, :source_type => 'Asteroid'

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

  after_create :assign_station_occupation

  def assign_station_occupation
    # random_station_id = Station.pluck(:id).sample # TODO: make sure this is far from galaxe center !!
    # station_position = Station.find(random_station_id).position

    station = Station.beginner.first
    # Position.create!(:positionable => self, :x => station_position.x, :y => station_position.y)
    Occupation.create!(:character => self, :occupiable => station)
  end
end
