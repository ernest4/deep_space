class Occupation < ApplicationRecord
  belongs_to :character
  belongs_to :occupiable, :polymorphic => true
end
