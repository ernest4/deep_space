class BattleComponent < ApplicationComponent
  def call
    div do
      c UI::CardComponent.new(:body => "BATTLE WIP !!!")
    end
  end
end
