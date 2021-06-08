class NavbarComponent < ApplicationComponent
  def c_render
    div(:class => "bg-red-500 fixed top-0 w-screen") do
      div(:class => "ds-global-container") do
        home_icon
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
    c link_to("deep space", "/", :class => "wip_TODO")
  end
end

# TODO: finish out the navbar to get idea for it's size.
# maybe go with non fixed header? most action will happen down below..

# all the chat will probs happen on the sticky footer on the bottom as well..