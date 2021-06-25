# TODO: specs
class Ship < ApplicationRecord
  include Stateful
  include Composite

  states ["repairing", "ready", "destroyed"]

  # TODO: add max hitpoints
  # TODO: add kill count
  # TODO: add rank (level)

  # t.integer :max_hitpoints
  # t.integer :evasiveness_percent
  # t.integer :accuracy_percent
  # t.integer :armour
  # t.integer :max_armour
  # t.integer :shields
  # t.integer :max_shields
  # t.integer :fire_range
  # t.integer :xp
  # t.integer :kills
  # t.integer :shots
  # t.integer :hits
  # t.integer :evasions
  # t.bigint :sub_commander_id

  composer
  composes :hulls
  # composes :engines
  # composes :amours
  # composes :shields
  # composes :weapons

  belongs_to :character

  scope :battle_set, ->(battle_set) { where(:battle_set => battle_set.presence || "default") }

  # def friend_of?(character)
  #   character.ships.exists?(:id => id)
  # end

  # def foe?
  #   !friend?
  # end
end
