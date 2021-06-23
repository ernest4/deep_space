# frozen_string_literal: true

# TODO: buggy
module UI
  module Button
    class ShowComponent < ApplicationComponent
      def initialize(button:, show:, group_id: nil)
        @button = button
        @show = show
        @group_id = group_id
        @content_id = SecureRandom.uuid
      end

      def call
        capture do
          c div(:data => { :controller => "show", "show-content-id-value" => @content_id }) {
            c button
            c show
          }
        end
      end

      private

      def button
        div(:data => { :action => "click->show#show" }, :class => "w-max") { @button }
      end

      def show
        div(:class => "hidden", :data => { "show-target" => "content", "show-group-id-value" => @group_id  }, :id => @content_id) do
          c @show
        end
      end
    end
  end
end
