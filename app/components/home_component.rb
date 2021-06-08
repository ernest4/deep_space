# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
  end

  def c_render
    c_div(:class => "pt-2 bg-blue-500")
    banner
    player_counts(@user_counts)
    features
    # c_div(:class => "bg-red-500", :data => { :some => "attribute" }) do
    #   c "wow"
    #   c "ENV: #{Rails.env}"
    #   c_div do
    #     "testy 123"
    #   end
    #   c TestyComponent.new
    #   c TestyComponent.new
    #   c [TestyComponent.new, TestyComponent.new]
    #   c_span do
    #     "testy 456"
    #   end
    # end
  end

  private

  def banner
    # TODO: i think i can drop the "c_" part ....
    c_div(:class => "ds-container") do
      "banner wip"
    end
  end

  def player_counts(user_counts)
    c CardComponent.new(:header => "Online Users", :body => user_counts.to_s)
  end

  def features
    c_div(:class => "ds-container") do
      c_span("features wip", :class => "ds-text")
      c_span("features wip primary", :class => "ds-text-primary")
      c_span("features wip secondary", :class => "ds-text-secondary")
    end
  end
end
