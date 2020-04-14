# frozen_string_literal: true

class AddColumnToAppliedJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :firstname, :string
    add_column :applied_jobs, :lastname, :string
    add_column :applied_jobs, :email, :string
    add_column :applied_jobs, :contact, :string
    add_column :applied_jobs, :cgpa, :string
    add_column :applied_jobs, :years_of_experience, :string
    add_column :applied_jobs, :resume, :string
    add_reference :applied_jobs, :user, foreign_key: true
    add_reference :applied_jobs, :opening_job, foreign_key: true
  end
end
