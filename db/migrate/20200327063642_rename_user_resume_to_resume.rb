# frozen_string_literal: true

# migration for changing userresume to resume
class RenameUserResumeToResume < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_resumes, :resumes
  end
end
