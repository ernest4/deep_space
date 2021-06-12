class GoogleSignInButtonComponent < ApplicationComponent
  # NOTE: this is a necessary hack. The render helpers from the gem don't work in straight component
  # render, therefore, need to use it via partial instead
  def call
    render :partial => "/google_sign_in_button"
  end
end
