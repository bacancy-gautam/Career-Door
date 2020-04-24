# frozen_string_literal: true

class Room2Channel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_for current_user
    # console.log(current_company)
    # company = Company.find(params[:id])
    # stream_for company
    # stream_from "room_channel254"
    if current_user.present?
      stream_from "current_company_#{current_user.id}"
    else
      stream_from 'admin_channel'
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
