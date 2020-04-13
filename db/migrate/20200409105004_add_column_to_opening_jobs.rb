class AddColumnToOpeningJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :opening_jobs, :technologies, :string
  end
end
