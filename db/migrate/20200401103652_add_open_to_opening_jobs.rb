class AddOpenToOpeningJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :opening_jobs, :open, :boolean, default: false
  end
end
