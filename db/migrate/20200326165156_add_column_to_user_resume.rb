# frozen_string_literal: true

# migration to add columns into user_resume model
class AddColumnToUserResume < ActiveRecord::Migration[6.0]
  def change
    add_column :user_resumes, :resume_name, :string
    add_column :user_resumes, :resume, :string
  end
end
