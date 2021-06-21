# TODO: specs
class Ship < ApplicationRecord
  STATES = ["repairing", "ready", "destroyed"].freeze
  include Stateful

  belongs_to :character

  scope :battle_set, ->(battle_set) { where(:battle_set => battle_set.presence || "default") }

  # def friend_of?(character)
  #   character.ships.exists?(:id => id)
  # end

  # def foe?
  #   !friend?
  # end
end
