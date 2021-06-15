module Galaxy
  class MapComponent < ApplicationComponent
    def initialize(center:)
      @center = center
      @range = 10
      @positions = Position.around(:center => center, :range => range)
    end
    def call
      c "map WIP"
    end
  end
end
