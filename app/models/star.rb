class Star < ApplicationRecord
  include Occupiable

  occupied
  occupiers :characters

  # TODO: not sure of the need for this yet...
  has_one :position, :as => :positionable, :dependent => :destroy
end
