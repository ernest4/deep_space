# frozen_string_literal: true

# This is for views only really...
module Reactified
  extend ActiveSupport::Concern

  # delegate :div, :span, :br, :button, :img, :form, :to => :tag

  TAGS = [:div, :span, :br, :button, :img, :form].freeze
  RENDER_TAGS = TAGS.map { |regular_tag| "c_#{regular_tag}".to_sym }.freeze

  included do
    # def cc(*elements)
    #   @children = elements
    #   self
    # end

    def c(element)
      return concat(normalize_element(element)) unless element.is_a?(Array)

      element.map { |child| concat(normalize_element(child)) }
    end

    def method_missing(method, *args, &block)
      super unless expected_tag?(method)
      handle_tag(method, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?('c_') || super
    end

    def call
      capture do
        c_render
      end
    end
  end

  def expected_tag?(method)
    RENDER_TAGS.any?(method)
  end

  def handle_tag(method, *args, &block)
    raw_tag = strip_tag_prefix(method)
    c(tag.send(raw_tag, *args, &block))
  end

  def strip_tag_prefix(tag_name)
    tag_name[2..]
  end

  def children
    return normalize_element(@children) unless @children.is_a?(Array)

    @children.map { |child| normalize_element(child) }
  end

  def normalize_element(element)
    element&.respond_to?(:render_in) ? render(element) : element
  end
end
