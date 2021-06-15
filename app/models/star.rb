class Star < ApplicationRecord
  has_one :position, :as => :positionable, :dependent => :destroy
end
