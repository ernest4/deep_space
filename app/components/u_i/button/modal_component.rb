# frozen_string_literal: true

module UI
  module Button
    class ModalComponent < ApplicationComponent
      def initialize(button:, modal:)
        @button = button
        @modal = modal
        @content_id = SecureRandom.uuid
      end

      def call
        capture do
          c div(:data => { :controller => "modal", "modal-content-id-value" => @content_id }) {
            c button
            c modal
          }
        end
      end

      private

      # def header
      #   div(:class => "flex justify-between") do
      #     c @card_arguments[:header].presence || span
      #     c close_button
      #   end
      # end

      def button
        div(:data => { :action => "click->modal#show" }) { @button }
      end

      def modal
        div(:class => "hidden", :data => { "modal-target" => "content" }, :id => @content_id) do
          c div(:class => "flex justify-between") {
            c span # for flex layout
            c close_button
          }
          c @modal
        end
      end

      def close_button
        div("Close",
            :data => { # super dirty looking method...but hey it works :)
              :controller => "modal",
              "modal-content-id-value" => @content_id,
              :action => "click->modal#close"
            },
            :class => "g-button-secondary g-small")
      end
    end
  end
end
