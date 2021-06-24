# frozen_string_literal: true

module UI
  class CardComponent < ApplicationComponent
    def initialize(body:, header: nil, footer: nil, primary: false, danger: false, style: nil)
      @header = header
      @body = body
      @footer = footer
      @primary = primary
      @danger = danger
      @style = style
    end

    def call
      container do
        c div(:class => "pt-2")
        c header
        c @body
        c footer
        c div(:class => "pt-2")
      end
    end

    private

    def container(&block)
      div(:class => "#{container_class} #{@style}") do
        block.call
      end
    end

    # NOTE: need to explicitly list classes here with full string, no crazy clever interpolations!
    # Otherwise tailwindcss prune won't detect the class properly and prune it from build !!!
    CONTAINER_CLASSES = {
      :secondary => "g-container",
      :primary => "g-container-primary",
      :danger => "g-container-danger"
    }.freeze

    def container_class
      return CONTAINER_CLASSES[:primary] if @primary
      return CONTAINER_CLASSES[:danger] if @danger

      CONTAINER_CLASSES[:secondary]
    end

    def header
      return if @header.blank?

      capture do
        c div(:class => header_class) {
          c @header
        }
        c div(:class => "pt-2")
        c UI::LineComponent.new(:primary => @primary, :danger => @danger)
        c div(:class => "pt-2")
      end
    end

    def header_class
      "#{header_text_color_class} font-bold"
    end

    # NOTE: need to explicitly list classes here with full string, no crazy clever interpolations!
    # Otherwise tailwindcss prune won't detect the class properly and prune it from build !!!
    HEADER_CLASSES = {
      :secondary => "g-text-secondary",
      :primary => "g-text-primary",
      :danger => "g-text-danger"
    }.freeze

    def header_text_color_class
      return HEADER_CLASSES[:primary] if @primary
      return HEADER_CLASSES[:danger] if @danger

      HEADER_CLASSES[:secondary]
    end

    def footer
      return if @footer.blank?

      capture do
        c div(:class => "pt-2")
        c UI::LineComponent.new
        c div(:class => "pt-2")
        c div(:class => "g-text italic text-gray-400 text-sm") {
          c @footer
        }
      end
    end
  end
end
