class BattleChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "user:#{current.user.id}"
    # stream_from "conversation_#{params[:stream]}_user_#{current_user.id}"

    # return unless params[:observer]

    # stream_from "user:#{current.user.id}"
    @battle = Battle.find(params[:battle_id])
    stream_from current_battle
    stream_from current_character
  end

  def testy(data)
    ActionCable.server.broadcast(current_battle, {:it_works => @battle.id, :extra => data["extra"]})
  end

  def current_battle
    "battle:#{@battle.id}"
  end

  def current_character
    "battle:#{@battle.id}:character:#{current.character.id}" # just for current user
  end

  # def dispatch(data)
  #   #   # follow actions/reducers analogy of sending messages from client to server
  #   #   # client substription is source of actions, server channel is the "reducer"

  #   case data['event']
  #   when 'SEEN'
  #     conversation_id = data['payload']['conversation_id']

  #     conversation = Conversation.find(conversation_id)

  #     if conversation.unseen_by == current_user
  #       conversation.update!(:unseen_count => 0, :notified_count => 0, :unseen_by => nil)
  #       ActionCable.server.broadcast(
  #         "conversation_observer_#{conversation_id}_user_#{current_user.id}",
  #         :message => { :status => 'confirmed' }
  #       )
  #     end
  #   end
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
