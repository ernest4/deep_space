class Asteroid < ApplicationRecord
  has_one :position, :as => :positionable, :dependent => :destroy
end
