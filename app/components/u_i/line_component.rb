# frozen_string_literal: true

module UI
  class LineComponent < ApplicationComponent
    def initialize(vertical: false)
      @vertical = vertical
    end

    def call
      @vertical ? div(:class => "bg-secondary w-px") : div(:class => "bg-secondary h-px")
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