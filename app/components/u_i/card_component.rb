# frozen_string_literal: true

module UI
  class CardComponent < ApplicationComponent
    def initialize(body:, header: nil, footer: nil)
      @header = header
      @body = body
      @footer = footer
    end

    def call
      div(:class => "ds-container") do
        c div(:class => "pt-2")
        c header
        c @body
        c footer
        c div(:class => "pt-2")
      end
    end

    private

    def header
      return if @header.blank?

      capture do
        c div(:class => "ds-text font-bold") {
          c @header
        }
        c div(:class => "pt-2")
        c UI::LineComponent.new
        c div(:class => "pt-2")
      end
    end

    def footer
      return if @footer.blank?

      capture do
        c div(:class => "pt-2")
        c UI::LineComponent.new
        c div(:class => "pt-2")
        c div(:class => "ds-text italic text-gray-400 text-sm") {
          c @footer
        }
      end
    end
  end
end
