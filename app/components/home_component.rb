# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def call
    capture do
      c div(:class => "pt-2 bg-blue-500")
      c jumbotron
      c player_counts(@user_counts)
      c features
    end
  end

  private

  def jumbotron
    div(:class => "ds-container") do
      c "jumbotron wip"
    end
  end

  def player_counts(user_counts)
    CardComponent.new(
      :header => "Players",
      :body => div do
        c user_counts.to_s
      end,
      :footer => span("testy spanny footery")
    )
  end

  def features
    div(:class => "ds-container") do
      c span("features wip", :class => "ds-text")
      c span("features wip primary", :class => "ds-text-primary")
      c span("features wip secondary", :class => "ds-text-secondary")
    end
  end
end
