class WelcomeComponent < ApplicationComponent
  def call
    capture do
      c UI::CardComponent.new(
        :body => body
      )
    end
  end

  def body
    div do
      c div {
        c "About half millennium ago, a strange artefact was discovered on earth that looked like a miniature black hole. It was emanating a strange energy, characteristically similar to what we best understood as \"dark energy\". The mass was extraordinarily dense, not unlike that of a black hole, it's properties similar to that of what we theorized to be \"dark matter\". The fragment would have swallowed the whole earth due to it's unbelievably strong gravitational pull, but was remarkably stable due to the dark energy that appeared to be modulating its gravitational energy and keeping it in check."
        c div(:class => "pt-4")
        c "A couple of centuries past. Many wars were fought over this artifact. It changed many hands. With each new owner, novel insights were gained, but nothing was shared..."
        c div(:class => "pt-4")
        c "...until 2301..."
        c div(:class => "pt-4")
        c "We were up against a wall. The planet was fast depleting of it's natural resources and numerous wars and conflicts had only accelerated this. We were facing extinction. We decided to put our differences behind, even if temporarily and pool all the knowledge we had accumulated about the artefact."
        c div(:class => "pt-4")
        c "It turned out that the dark energy was also a signal that appeared to communicate with something. We couldn't decipher the signal, but we could tell it's direction and discovered that there were other sources of this signal, on other planets far far away. We knew without a doubt now that this was a spacefaring race which left this artifact behind and it must hold the key to space travel itself. After desperate collective and collaborative research effort on an unprecedented scale, we synthesized our own stable \"miniature black holes\" and so the first warp drivers were born. They operated on a principle of controlling the gravitational pull of dark mass via dark energy, in order to bend the spacetime around the vessel and propel it forward. It's as if the vessel is riding on a \"space wave\"."
        c div(:class => "pt-4")
        c "There were only enough resources left to build a couple modest spaceships to leave earth and we had chosen our best and brightest, you, to lead them."
        c div(:class => "pt-4")
        c "Among the strongest sources of the dark energy signal was the black hole from our own galaxy. We thus set our sights there as the final destination. We hope to perhaps get some answers on who built these artifacts, why and where they are now?"
        c div(:class => "pt-4")
        c "Early enough in the journey you discover that we're not alone after all, there are other alien races! They have developed warp drives, just as we have, from the other artefacts we saw signals from earlier. Some, more friendlier than others, but all with a similar goal of seeking answers at the centre of our galaxy. Collectively, the alien races developed space station hubs as key neutral meeting points for trade and truce agreements, safe havens for travelers. You find yourself at one of these hubs now."
      }
      c div(:class => "pt-4")
      c span("Ad Astra, our journey begins...")
      c form_with(:model => Character.new, :local => true) { |form|
        c form.text_field(:name)
        c form.submit "Begin", :disable_with => "...checking..."
      }
    end
  end
end
