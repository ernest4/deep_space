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
    c_div(:class => "ds-container") do
      "banner wip"
    end
  end

  def player_counts(user_counts)
    c_div(:class => "ds-container") do
      c(user_counts.to_s)
    end
  end

  def features
    c_div(:class => "ds-container") do
      "features wip"
    end
  end
end
