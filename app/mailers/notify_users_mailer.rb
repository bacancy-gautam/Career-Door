# frozen_string_literal: true

# mailer for sending notifications to user
class NotifyUsersMailer < ApplicationMailer
  def notify_users_for_new_job(user, job)
    @user = user
    @job = job
    if user.years_of_experience >= job.experience
      mail to: @user.email, subject: 'new job opening', from: 'service.eagle12@gmail.com'  
    end
  end
end
