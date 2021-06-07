# frozen_string_literal: true

class HomeComponent < ApplicationComponent
  def initialize(user_counts:)
    @user_counts = user_counts
    # TODO: get counts users => {:now => ..., :last_24h => ..., :all_time => ...}
  end

  def c_render
    c_div(:class => "bg-red-500", :data => { :some => "attribute" }) do
      c "wow"
      c_div do
        "testy 123"
      end
      c TestyComponent.new
      c TestyComponent.new
      c [TestyComponent.new, TestyComponent.new]
      c_span do
        "testy 456"
      end
    end
  end
end
