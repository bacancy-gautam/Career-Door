class CreateOpeningJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :opening_jobs do |t|
      t.references :company, index: true, null: true, foreign_key: true
      t.references :technology, index: true, null: true, foreign_key: true
      t.integer :experience
      t.string :job_role
      t.text :description
      t.decimal :cgpa, precision: 64, scale: 12
      t.timestamps
    end
  end
end
