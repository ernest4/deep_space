# frozen_string_literal: true

module UI
  class LineComponent < ApplicationComponent
    def call
      div(:class => "bg-secondary h-px")
    end
  end
end
