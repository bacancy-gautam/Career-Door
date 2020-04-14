class RemoveColumnFromOpeningJob < ActiveRecord::Migration[6.0]
  def change
    remove_reference :opening_jobs, :technology, index: true, foreign_key: true
  end
end
