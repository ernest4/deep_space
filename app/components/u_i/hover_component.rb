# frozen_string_literal: true

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
      div(:data => { :action => "mouseover->hover#show mouseout->hover#hide" }) { @trigger }
    end

    def hover
      div(:class => "bg-green-500 hidden fixed h-72 overflow-scroll", :data => { "hover-target" => "content", :controller => "hover", :action => "mouseover->hover#show mouseout->hover#hide", "hover-content-id-value" => @content_id, }, :id => @content_id) do
        c div(:class => "flex") {
          c div(:class => "pl-4")
          c div {
            c div(:class => "pt-4")
            c @hover
          }
          c div(:class => "pl-4")
        }
      end
    end
  end
end
