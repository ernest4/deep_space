# frozen_string_literal: true

class FlashComponent < ApplicationComponent
  def render?
    flash[:g].present?
  end

  # TODO: need a close button, probably stimulus.js powered.

  def call
    div do
      flashes.each do |key, messages|
        messages.each do |message|
          c div(:class => "pt-4")
          c UI::CardComponent.new({
            :header => "#{key.capitalize}!",
            :body => body(key, message)
          }.merge(type(key)))
        end
      end
    end
  end

  private

  def body(key, message)
    div(:class => body_class(key)) do
      c message
    end
  end

  # NOTE: need to explicitly list classes here with full string, no crazy clever interpolations!
  # Otherwise tailwindcss prune won't detect the class properly and prune it from build !!!
  BODY_CLASSES = {
    :secondary => "text-secondary",
    :primary => "text-primary",
    :danger => "text-danger"
  }.freeze

  def body_class(key)
    message_type = type(key)

    return BODY_CLASSES[:primary] if message_type[:primary]
    return BODY_CLASSES[:danger] if message_type[:danger]

    BODY_CLASSES[:secondary]
  end

  def type(key)
    return { :primary => true } if key.to_s == "success"
    return { :danger => true } if key.to_s == "error"

    {}
  end
end
