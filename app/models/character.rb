# TODO: SPECS
class Character < ApplicationRecord
  belongs_to :user
  has_one :position, :as => :positionable, :dependent => :destroy

  # TODO: SPECS
  validates :name, :length => { :in => 2..12 }

  # after_commit :assign_position, :on => [:create]
  # TODO: SPECS
  after_create :assign_position

  def assign_position
    random_station_id = Station.pluck(:id).sample # TODO: make sure this is far from galaxe center !!
    station_position = Station.find(random_station_id).position
    Position.create!(:positionable => self, :x => station_position.x, :y => station_position.y)
  end
end
