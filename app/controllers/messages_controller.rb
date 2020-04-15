# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @messages = current_company.messages.order('created_at ASC')
    @message = Message.new
    # binding.pry
  end

  def create
    message = Message.new(allowed_parameters)
    message.save!
    # binding.pry
    company = (company_signed_in? ? current_company : Company.find(params[:message][:company_id]))
    # ActionCable.server.broadcast 'room_channel', content: message
    @messages = company.messages.order('created_at ASC')
    ActionCable.server.broadcast 'admin_channel', content: message
    ActionCable.server.broadcast "current_company_#{company.id}", content: message
  end

  def new_message
    @company = Company.find(params[:id])
    @message = Message.new
    @messages = @company.messages.order('created_at ASC')
  end

  private

  def find_resume
    @resume = current_user.resumes.find(params[:id])
  end

  def allowed_parameters
    params.require(:message).permit(:msg, :company_id, :user_id)
  end
end
