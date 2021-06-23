# frozen_string_literal: true

# TODO: specs
module UI
  class HoverComponent < ApplicationComponent
    def initialize(trigger:, hover:)
      @trigger = trigger
      @hover = hover
      @content_id = SecureRandom.uuid
    end

    def call
      capture do
        c div(:data => { :controller => "hover", "hover-content-id-value" => @content_id }) {
          c trigger
          c hover
        }
      end
    end

    def trigger
      div(:data => { :action => "mousemove->hover#show mouseleave->hover#hide" }) { @trigger }
    end

    def hover
      # div(:class => "hidden fixed", :data => { "hover-target" => "content", :controller => "hover", :action => "mouseenter->hover#show mouseleave->hover#hide", "hover-content-id-value" => @content_id }, :id => @content_id) do
      div(:class => "hidden fixed fixed bg-gray-700 bg-opacity-90 hidden", :data => { "hover-target" => "content" }, :id => @content_id) do
        c @hover
      end
    end
  end
end
