# frozen_string_literal: true

# add user_id as foreign key in resumes
class AddUserToResumes < ActiveRecord::Migration[6.0]
  def change
    add_reference :resumes, :user, foreign_key: true
  end
end
