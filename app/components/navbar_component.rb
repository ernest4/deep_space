class NavbarComponent < ApplicationComponent
  def call
    div(:class => "bg-red-500 fixed top-0 w-screen") do
      c div(:class => "ds-global-container") do
        c home_icon
        # outlier_studio
        # # youtube # TODO: once you have at least 1 video
        # twitter
        # discord
        # luminaries
        # profile => {logged_out => google_login, logged_in => (view profile, settings, logout)}
      end
    end
  end

  private

  def home_icon
    link_to(Constants::GAME_NAME, "/", :class => "wip_TODO")
  end
end

# TODO: finish out the navbar to get idea for it's size.
# maybe go with non fixed header? most action will happen down below..

# all the chat will probs happen on the sticky footer on the bottom as well..
