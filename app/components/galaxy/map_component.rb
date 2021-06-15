module Galaxy
  class MapComponent < ApplicationComponent
    def initialize(center:)
      @center = center
      @range = 10 # TODO: allow "zoom" change on front end will set this value basically, the more you zoom out the bigger the range you can see
      positions = Position.around(:center => @center, :range => @range).order(:x => :asc) # NOTE: very important for X to be ascending for grid calculation
      @positions_in_grid = generate_grid_from_positions(positions, @center, @range)
    end

    def call
      # TODO: drawing the grid map...
      div(:class => "") do
        @positions_in_grid.each do |row|
          c draw_row(row)
        end
      end
    end

    private

    def generate_grid_from_positions(positions, center, range)
      grid_with = range * 2
      grid_height = range * 2
      grid = grid_height.times.map { grid_with.times.map {nil} } # creates a grid of nils

      positions.each do |position|
        grid_y = ((position.y % range) + (center[:y] % range))
        grid_x = ((position.x % range) + (center[:x] % range))

        # debugger
        # grid[grid_y][grid_x] = position.positionable.name # TESTING
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
      # TODO: draw different graphics for different things
      div(:class => "g-text") do
        if position.present?
          c position.positionable.name
        else
          c "+"
        end
      end
    end
  end
end
