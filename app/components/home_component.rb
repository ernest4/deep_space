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
        c span("alliances", :class => "ds-text-tertiary")
        c ", "
        c span("trade", :class => "ds-text-tertiary")
        c ", "
        c span("fight", :class => "ds-text-tertiary")
        c " and "
        c span("discover", :class => "ds-text-tertiary")
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
    feature_lists = {
      :available => {
        :subtitle => "",
        :features => [
          { :title => "feature one", :description => "lorem ipsum" },
          { :title => "feature two", :description => "lorem ipsum" }
        ]
      },
      :planned => {
        :subtitle => "Subject to change / addition / removal",
        :features => [
          { :title => "feature one", :description => "lorem ipsum" },
          { :title => "feature two", :description => "lorem ipsum" }
        ]
      }
    }
    UI::CardComponent.new(
      :header => span("Features", :class => "font-bold"),
      :body => div do
        feature_lists.each do |feature_list_name, feature_list|
          c span(feature_list_name.capitalize, :class => "sv-text font-bold")
          if feature_list[:subtitle].present?
            c div(feature_list[:subtitle], :class => "ds-text italic text-gray-400 text-sm")
          end

          c div(:class => "pt-2")
          feature_list[:features].each do |feature|
            c div(:class => "pt-2")
            c div(feature[:title], :class => "ds-text-secondary")
            c div(feature[:description], :class => "ds-text text-sm")
          end
          c div(:class => "pt-8")
        end
      end
    )
  end
end
