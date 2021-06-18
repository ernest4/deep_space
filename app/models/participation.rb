class Participation < ApplicationRecord
  belongs_to :character
  belongs_to :participatable, :polymorphic => true
end
