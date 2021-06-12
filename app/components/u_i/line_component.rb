# frozen_string_literal: true

module UI
  class LineComponent < ApplicationComponent
    def initialize(vertical: false, primary: false, danger: false)
      @vertical = vertical
      @primary = primary
      @danger = danger
    end

    def call
      return div(:class => "#{line_color_class} w-px") if @vertical

      div(:class => "#{line_color_class} h-px")
    end

    # NOTE: need to explicitly list classes here with full string, no crazy clever interpolations!
    # Otherwise tailwindcss prune won't detect the class properly and prune it from build !!!
    LINE_COLOR_CLASSES = {
      :secondary => "bg-secondary",
      :primary => "bg-primary",
      :danger => "bg-danger"
    }.freeze

    private

    def line_color_class
      return LINE_COLOR_CLASSES[:primary] if @primary
      return LINE_COLOR_CLASSES[:danger] if @danger

      LINE_COLOR_CLASSES[:secondary]
    end
  end
end

# original from top-fuel-spacer
# const Line = ({ size, vertical, primary, ...props }) => {
#   const { primary: primaryBackground, secondary: secondaryBackground } = useTheme();

#   return (
#     <Spacing
#       {...{
#         background: primary ? primaryBackground : secondaryBackground,
#         height: vertical ? "auto" : `${size || 1}px`,
#         width: vertical ? `${size || 1}px` : "100%",
#         ...props,
#       }}
#     />
#   );
# };
