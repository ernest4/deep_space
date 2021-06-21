# TODO: specs
class FleetGenerator < ApplicationAction
  def initialize(category_counts)
    @category_counts = category_counts
  end

  def call
    ships = []
    @category_counts.each do |category, count|
      new_ships = []
      count.times { new_ships.push(ShipGenerator.call(:category => category)) }
      ships += new_ships
    end
    ships
  end
end
