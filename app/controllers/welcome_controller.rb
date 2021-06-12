class WelcomeController < ApplicationController
  # before_action :set_user, :only => %i[show edit update destroy]

  # # GET /users or /users.json
  def index
    # @users = User.all

    render WelcomeComponent.new
  end

  # GET /users/1 or /users/1.json
  # def show
  #   user_counts = {
  #     :now => User.online.count,
  #     :last_24h => User.last_online(1.day.ago).count,
  #     :all_time => User.count
  #   }

  #   render HomeComponent.new(:user_counts => user_counts)
  # end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_user
  #   @user = User.find(params[:id])
  # end

  # # Only allow a list of trusted parameters through.
  # def user_params
  #   params.fetch(:user, {})
  # end
end
