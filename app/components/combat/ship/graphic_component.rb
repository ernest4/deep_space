# TODO: specs

module Combat
  module Ship
    class GraphicComponent < ApplicationComponent
      def initialize(ship:, scale: nil)
        @ship = OpenStruct.new(ship)
        # @scale = scale
      end

      def call
        capture do
          c send("draw_#{@ship.category}_ship", @ship)
        end
      end

      def draw_small_ship(ship)
        div(:class => "w-10 h-4 bg-green-500", :id => ship_id(ship))
      end

      def draw_medium_ship(ship)
        div(:class => "w-20 h-8 bg-blue-500", :id => ship_id(ship))
      end

      def draw_large_ship(ship)
        div(:class => "w-40 h-16 bg-yellow-500", :id => ship_id(ship))
      end

      def ship_id(ship)
        "ship_#{ship.id}"
      end
    end
  end
end
