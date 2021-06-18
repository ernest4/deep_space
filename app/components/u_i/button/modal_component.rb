# frozen_string_literal: true

module UI
  module Button
    class ModalComponent < ApplicationComponent
      def initialize(button:, modal:)
        @button = button
        @modal = modal
      end

      def call
        capture do
          c div(:data => { :controller => "modal" }) {
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
        div(:class => "hidden", :data => { "modal-target" => "content" }, :id => SecureRandom.uuid) do
          c div(:class => "flex justify-between") {
            c span # for flex layout
            c close_button
          }
          c @modal
        end
      end

      def close_button
        div("Close", :data => { :action => "click->modal#close" }, :class => "g-button-secondary g-small")
      end
    end
  end
end
