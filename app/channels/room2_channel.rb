class Room2Channel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_for current_user
    stream_from "current_user_#{current_user.id}"
    # stream_from "room_channel2"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
