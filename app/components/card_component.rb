class CardComponent < ApplicationComponent
  def initialize(header: nil, &children)
    @header = header
    @children = children
  end

  def c_render
    div(:class => "ds-container ds-text") do
      c @header
      line if @header.present?
      c @children.call
    end
  end

  def line
    div(:class => "bg-secondary h-px")
  end
end


# bit confusing, some stuff (tags) auto concats because of reactified concern
# but then other things dont concat automatically, but if reactified tag will be used
# it WILL autoconcat and then might autoconcat again causing duplication...

# NEED to either definitevely resolve Reactified so concat is never needed when writing
# component, OR ALWAYS concat manually in component render and simplify reactified
# concern. Both not gonna work same time !!!