# frozen_string_literal: true

# This is for views only really...
module Reactified
  extend ActiveSupport::Concern

  delegate :div, :span, :br, :button, :img, :form, :to => :tag

  included do
    def c(element)
      return concat(normalize_element(element)) unless element.is_a?(Array)

      element.map { |child| concat(normalize_element(child)) }
    end
  end

  def normalize_element(element)
    element&.respond_to?(:render_in) ? render(element) : element
  end
end
