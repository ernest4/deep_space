class Station < ApplicationRecord
  include Occupiable

  has_one :position, :as => :positionable, :dependent => :destroy

  BEGINNER_STATION_NAME = "Galactic Hub".freeze
  scope :beginner, -> { where(:name => BEGINNER_STATION_NAME) }
end
