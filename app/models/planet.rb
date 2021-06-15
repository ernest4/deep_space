class Planet < ApplicationRecord
  has_one :position, :as => :positionable, :dependent => :destroy
end
