# frozen_string_literal: true

# TODO: specs
module UI
  class HoverComponent < ApplicationComponent
    def initialize(trigger:, hover:, anchor_id: nil)
      @trigger = trigger
      @hover = hover
      @content_id = SecureRandom.uuid
      @anchor_id = anchor_id
    end

    def call
      capture do
        c div(:data => { :controller => "hover", "hover-content-id-value" => @content_id, "hover-anchor-id-value" => @anchor_id }) {
          c trigger
          c hover
        }
      end
    end

    def trigger
      div(:data => { :action => "mousemove->hover#show mouseleave->hover#hide" }) { @trigger }
    end

    def hover
      fixed = "fixed" if @anchor_id.blank?
      # div(:class => "hidden fixed", :data => { "hover-target" => "content", :controller => "hover", :action => "mouseenter->hover#show mouseleave->hover#hide", "hover-content-id-value" => @content_id }, :id => @content_id) do
      div(:class => "hidden #{fixed}", :data => { "hover-target" => "content" }, :id => @content_id) do
        c @hover
      end
    end
  end
end
