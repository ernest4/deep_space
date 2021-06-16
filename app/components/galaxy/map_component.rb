module Galaxy
  class MapComponent < ApplicationComponent
    def initialize(center:)
      @center = center
      @range = 10 # TODO: allow "zoom" change on front end will set this value basically, the more you zoom out the bigger the range you can see
      positions = Position.around(:center => @center, :range => @range).order(:x => :asc).includes(:positionable) # NOTE: very important for X to be ascending for grid calculation
      @positions_in_grid = generate_grid_from_positions(positions, @center, @range)
    end

    def call
      # TODO: drawing the grid map...
      div(:class => "border border-red-500") do
        @positions_in_grid.each do |row|
          c draw_row(row)
        end
      end
    end

    private

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
      # div(:class => "flex justify-between") do
        row.each do |column|
          c draw_position(column)
        end
      # end
    end

    def draw_position(position)
      # TODO: draw different graphics for different things
      # div(:class => "border border-white h-16 w-16") do
        if position.present?
          c draw_graphic(position)
        else
          # c div(:class => "w-16 h-16")
          nil
        end
      # end
    end

    # TODO: wip
    def draw_graphic(position)
      y = (position.y - @center[:y]) + @range
      x = (position.x - @center[:x]) + @range

      return draw_planet(position, x, y) if position.positionable.class.to_s == "Planet"
      return draw_star(position, x, y) if position.positionable.class.to_s == "Star"
      return draw_station(position, x, y) if position.positionable.class.to_s == "Station"
      return draw_asteroid(position, x, y) if position.positionable.class.to_s == "Asteroid"

      # NOTE: for debugging only !!
      return draw_character(position, x, y) if position.positionable.class.to_s == "Character"

      nil
    end

    def draw_planet(position, x, y)
      div(:class => "absolute rounded-full bg-blue-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(20)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_star(position, x, y)
      div(:class => "absolute rounded-full bg-yellow-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(30)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_station(position, x, y)
      div(:class => "absolute rounded-full bg-white", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(10)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_asteroid(position, x, y)
      div(:class => "absolute rounded-full bg-gray-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(12)") do
        # c "#{position.positionable.name.first}_#{position.positionable.name.split('_').last}"
      end
    end

    def draw_character(_position, x, y)
      div(:class => "absolute rounded-full bg-red-500", :style => "top: calc(4rem * #{y}); left: calc(4rem * #{x}); width: 2px; height: 2px; transform: scale(9)")
    end
  end
end
