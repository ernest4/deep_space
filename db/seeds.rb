# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TODO: seed with game specific initial data.
# TODO: build admin front end to edit / add more stuff to DB to facilitate content generation.

# this will delete all positionables and their positions
Position.all.each { |position| position.positionable.destroy! }

PLANET = "Planet".freeze
STAR = "Star".freeze
STATION = "Station".freeze
ASTEROID = "Asteroid".freeze

LOCATIONS = [PLANET, STAR, STATION, ASTEROID].freeze

positions = 100.times.map do |i|
  {
    :x => i,
    :y => i,
    :type => LOCATIONS[i % 4],
    :type_info => {
      :name => "#{LOCATIONS[i % 4]}_#{i}"
    }
  }
end

def create_positionable(position)
  position[:type].to_s.constantize.create!(position[:type_info])
end

positions.each do |position|
  positionable = create_positionable(position)
  Position.create!(:positionable => positionable, :x => position[:x], :y => position[:y])
end
