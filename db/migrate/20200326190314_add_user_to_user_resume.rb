# frozen_string_literal: true

# migration for adding user as a foregin key into user resume model
class AddUserToUserResume < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_resumes, :user, foreign_key: true
  end
end
