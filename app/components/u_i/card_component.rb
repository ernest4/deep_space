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
        c header
        c @body
        c footer
      end
    end

    def header
      capture do
        c @header if @header.present?
        c UI::LineComponent.new if @header.present?
      end
    end

    def footer
      capture do
        c UI::LineComponent.new if @footer.present?
        c @footer
      end
    end
  end
end
