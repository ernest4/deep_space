# TODO: specs
class Ship < ApplicationRecord
  STATES = ["repairing", "ready", "destroyed"].freeze
  include Stateful

  belongs_to :character

  scope :battle_set, ->(battle_set) { where(:battle_set => battle_set.presence || "default") }
end
