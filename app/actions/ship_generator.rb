# TODO: specs
class ShipGenerator < ApplicationAction
  HITPOINTS = {
    :small => 100,
    :medium => 200,
    :large => 300
  }.freeze

  SHIP_NAMES = [
    'little',
    'orion',
    'sparkle',
    'blazer',
    'phaser',
    'blinks-a-lot',
    'sir',
    'big',
    'rocket',
    'beep',
    'boop',
    'bop',
    'GR8',
    'G6'
  ].freeze

  def initialize(category:)
    @category = category
  end

  def call
    # Ship.new.tap do |ship|
    #   ship.category = @category
    #   ship.state = "ready"
    #   ship.hitpoints = HITPOINTS[@category]
    #   ship.name = generate_ship_name
    # end
    ship = Ship.new
    ship.category = @category
    ship.state = "ready"
    ship.hitpoints = HITPOINTS[@category.to_sym]
    ship.name = generate_ship_name
    ship
  end

  private

  def generate_ship_name
    first_name = SHIP_NAMES[rand(SHIP_NAMES.size)]

    last_name = nil
    loop do
      last_name = SHIP_NAMES[rand(SHIP_NAMES.size)]

      break if last_name != first_name
    end

    "#{first_name} #{last_name}"
  end
end
