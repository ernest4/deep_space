# TODO: specs
class TestyMotionComponent < ApplicationComponent
  include Motion::Component

  # around_action :with_current_user

  def initialize
    @count = 0
    # @char = nil
    @current_user = OpenStruct.new(Current.user.attributes)
  end

  # def with_current_user(&block)
  #   Current.set(:user => @current_user, &block)
  # end

  map_motion :add

  def add
    @count += 1
    @char = @current_user.email
  end

  def call
    div do
      c div(:class => "pt-8")
      c div(:class => "g-text") {
        c @count
        c @char
      }
      c div("add", :class => "g-button-secondary", :data => { :motion => :add })
    end
  end
end
