# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def c_render
    div(:class => "pt-2 bg-blue-500")
    jumbotron
    c player_counts(@user_counts)
    features
    # div(:class => "bg-red-500", :data => { :some => "attribute" }) do
    #   c "wow"
    #   c "ENV: #{Rails.env}"
    #   div do
    #     "testy 123"
    #   end
    #   c TestyComponent.new
    #   c TestyComponent.new
    #   c [TestyComponent.new, TestyComponent.new]
    #   span do
    #     "testy 456"
    #   end
    # end
  end

  private

  def jumbotron
    # TODO: i think i can drop the "" part ....
    div(:class => "ds-container") do
      "jumbotron wip"
    end
  end

  def player_counts(user_counts)
    CardComponent.new(:header => "Online Users") do
      user_counts.to_s
    end
  end

  def features
    div(:class => "ds-container") do
      span("features wip", :class => "ds-text")
      span("features wip primary", :class => "ds-text-primary")
      span("features wip secondary", :class => "ds-text-secondary")
    end
  end
end
