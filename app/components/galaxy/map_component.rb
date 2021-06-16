module Galaxy
  class MapComponent < ApplicationComponent
    def initialize(center:)
      @center = center
      @range = 5 # TODO: allow "zoom" change on front end will set this value basically, the more you zoom out the bigger the range you can see
      # positions = Position.around(:center => @center, :range => @range).order(:x => :asc).includes(:positionable) # NOTE: very important for X to be ascending for grid calculation
      positions = Position.around(:center => @center, :range => @range).order(:x => :asc) # NOTE: very important for X to be ascending for grid calculation
      @positions_in_grid = generate_grid_from_positions(positions, @center, @range)
    end

    def call
      # div(:class => "border border-red-500 relative") do
      div(:class => "relative") do
        c draw_grid
        c draw_grid_navigation
      end
    end

    private

    def draw_grid
      capture do
        @positions_in_grid.each do |row|
          c draw_row(row)
        end
      end
    end

    def draw_grid_navigation
      div(:class => "absolute top-0 left-0 w-full h-full flex flex-col justify-between items-center") do
        c div(:class => "cursor-pointer w-max") {
          c div(:class => "pt-6")
          c div("Up", :class => "g-button-secondary")
        }
        c div(:class => "flex justify-between w-full") {
          c div(:class => "cursor-pointer", :style => "transform: rotate(270deg);") {
            c div("Left", :class => "g-button-secondary")
          }
          c div(:class => "cursor-pointer", :style => "transform: rotate(90deg);") {
            c div("Right", :class => "g-button-secondary")
          }
        }
        c div(:class => "cursor-pointer w-max") {
          c div("Down", :class => "g-button-secondary")
          c div(:class => "pt-6")
        }
      end
    end

    def generate_grid_from_positions(positions, center, range)
      grid_with = range * 2
      grid_height = range * 2
      grid = grid_height.times.map { grid_with.times.map { nil} } # creates a grid of nils

      positions.each do |position|
        grid_y = (position.y - center[:y]) + range
        grid_x = (position.x - center[:x]) + range
        grid[grid_y][grid_x] = position
      end

      grid
    end

    def draw_row(row)
      div(:class => "flex justify-between") do
        row.each do |column|
          c draw_position(column)
        end
      end
    end

    def draw_position(position)
      # div(:class => "border border-white h-16 w-16") do
      div(:class => "h-16 w-16") do
        if position.present?
          c draw_graphic(position)
        else
          # c div(:class => "w-16 h-16")
          # nil
        end
      end
    end

    # TODO: wip extract out?
    def draw_graphic(position)
      y = (position.y - @center[:y]) + @range
      x = (position.x - @center[:x]) + @range

      return draw_planet(position, x, y) if position.positionable_type == "Planet"
      return draw_star(position, x, y) if position.positionable_type == "Star"
      return draw_station(position, x, y) if position.positionable_type == "Station"
      return draw_asteroid(position, x, y) if position.positionable_type == "Asteroid"

      # NOTE: for debugging only !!
      return draw_character(position, x, y) if position.positionable_type == "Character"

      nil
    end

    def draw_planet(position, x, y)
      # div(:class => "absolute rounded-full bg-blue-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(20)") do
      div(:class => "absolute rounded-full bg-blue-500", :style => "width: 2px; height: 2px; transform: scale(20)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_star(position, x, y)
      # div(:class => "absolute rounded-full bg-yellow-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(30)") do
      div(:class => "absolute rounded-full bg-yellow-500", :style => "width: 2px; height: 2px; transform: scale(30)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_station(position, x, y)
      # div(:class => "absolute rounded-full bg-white", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(10)") do
      div(:class => "absolute rounded-full bg-white", :style => "width: 2px; height: 2px; transform: scale(10)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_asteroid(position, x, y)
      # div(:class => "absolute rounded-full bg-gray-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(12)") do
      div(:class => "absolute rounded-full bg-gray-500", :style => "width: 2px; height: 2px; transform: scale(12)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_character(_position, x, y)
      # div(:class => "absolute rounded-full bg-red-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(9)")
      div(:class => "absolute rounded-full bg-red-500", :style => "width: 2px; height: 2px; transform: scale(9)")
    end
  end
end
