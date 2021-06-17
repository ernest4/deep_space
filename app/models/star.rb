class Star < ApplicationRecord
  include Occupiable

  has_one :position, :as => :positionable, :dependent => :destroy
end
