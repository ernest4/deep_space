class Position < ApplicationRecord
  belongs_to :positionable, :polymorphic => true
end
