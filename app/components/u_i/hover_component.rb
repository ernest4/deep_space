# frozen_string_literal: true

module UI
  class HoverComponent < ApplicationComponent
    def initialize(trigger:, hover:)
      @trigger = trigger
      @hover = hover
      # @content_id = SecureRandom.uuid

      # NOTE: make sure to utilize StimulusUse utilities here!
      # useHover

      # NOTE: implementation will be quite similar to modal in that the content will need to go to
      # the end of the page so i can reliably overlay anything.
    end

    def call
      # TODO: ...
    end
  end
end

# module UI
#   module Button
#     class ModalComponent < ApplicationComponent
#       def initialize(button:, modal:)
#         @button = button
#         @modal = modal
#         @content_id = SecureRandom.uuid
#       end

#       def call
#         capture do
#           c div(:data => { :controller => "modal", "modal-content-id-value" => @content_id }) {
#             c button
#             c modal
#           }
#         end
#       end

#       private

#       # def header
#       #   div(:class => "flex justify-between") do
#       #     c @card_arguments[:header].presence || span
#       #     c close_button
#       #   end
#       # end

#       def button
#         div(:data => { :action => "click->modal#show" }) { @button }
#       end

#       def modal
#         div(:class => "hidden fixed w-screen h-screen top-0 flex justify-center items-center bg-gray-900 bg-opacity-90", :data => { "modal-target" => "content" }, :id => @content_id) do
#           c div(:class => "overflow-scroll h-screen") {
#             c div(:class => "flex") {
#               c div(:class => "pl-4")
#               c div {
#                 c div(:class => "pt-4")
#                 c @modal
#                 c div(:class => "pt-2")
#                 c div(:class => "flex justify-between") {
#                   c close_button
#                   c span # for flex layout
#                 }
#                 c div(:class => "pt-4")
#               }
#               c div(:class => "pl-4")
#             }
#           }
#         end
#       end

#       def close_button
#         div("Close",
#             :data => { # super dirty looking method...but hey it works :)
#               :controller => "modal",
#               "modal-content-id-value" => @content_id,
#               :action => "click->modal#close"
#             },
#             :class => "g-button-secondary g-button-small")
#       end
#     end
#   end
# end
