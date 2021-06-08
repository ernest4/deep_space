class CardComponent < ApplicationComponent
  def initialize(header: nil, body:)
    @header = header
    @body = body
  end

  def c_render
    c_div(:class => "ds-container") do
      c @header
      c(line) if @header.present?
      c @body
    end
  end

  def line
    c_div(:class => "wip...")
  end
end
