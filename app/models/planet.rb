class Planet < ApplicationRecord
  include Occupiable

  occupied
  occupiers :characters

  has_one :position, :as => :positionable, :dependent => :destroy
end
