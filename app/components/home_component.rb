# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def call
    capture do
      c div(:class => "pt-2 bg-blue-500")
      c div(:class => "pt-4")
      c jumbotron
      c div(:class => "pt-4")
      c player_counts(@user_counts)
      c div(:class => "pt-4")
      c features
    end
  end

  private

  def jumbotron
    UI::CardComponent.new(
      :header => "About",
      :body => div do
        c span("Deep Space (DS)", :class => "ds-text-primary")
        c " is a text based MMORPG set in Milky Way Galaxy. You are the "
        c span("commander", :class => "ds-text-secondary")
        c " of your fleet of "
        c span("ships", :class => "ds-text-tertiary")
        c " and colonizer of "
        c span("planets", :class => "ds-text-tertiary")
        c "."
        c br
        c br
        c "Build yourself and your galactic empire your way with other "
        c span("players", :class => "ds-text-secondary")
        c " around the world. Form "
        c span("alliances", :class => "ds-text-tertiary") # TODO: need better, more convenient utilities for this
        c ", "
        c span("trade", :class => "ds-text-tertiary") # TODO: need better, more convenient utilities for this
        c ", "
        c span("fight", :class => "ds-text-tertiary") # TODO: need better, more convenient utilities for this
        c " and "
        c span("discover", :class => "ds-text-tertiary") # TODO: need better, more convenient utilities for this
        c " the mysteries of deep dark space."
        c br
        c br
        c "Lead the way, commander!" # TODO: make this a button.
      end
    )
  end

  def player_counts(user_counts)
    UI::CardComponent.new(
      :header => "Players Online",
      :body => div(:class => "flex justify-between") do
        user_counts.each_with_index do |user_count, index|
          type, count = user_count

          c span {
            c span(type.to_s.split("_").join(" "), :class => "ds-text-secondary")
            c " : "
            c span(count, :class => "sv-text font-bold")
          }

          next if index == user_counts.size - 1

          c div(:class => "flex") {
            c UI::LineComponent.new(:vertical => true)
            c span(:class => "pr-2")
          }
        end
      end,
      :footer => span("The game is in early stages of development. Why not invite your friends to play together?")
    )
  end

  def features
    UI::CardComponent.new(
      :header => span("testy custom element", :class => "font-normal"),
      :body => capture do
        c span("features wip", :class => "ds-text")
        c span("features wip primary", :class => "ds-text-primary")
        c span("features wip secondary", :class => "ds-text-secondary")
      end
    )
  end
end
