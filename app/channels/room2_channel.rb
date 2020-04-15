class Room2Channel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_for current_user
    # stream_from "room_channel2"
    stream_from "current_company_#{current_user.id}"
    
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
