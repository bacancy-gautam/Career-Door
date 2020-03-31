class CreateInterestedPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :interested_people do |t|
      t.belongs_to :user, index: true
      t.belongs_to :opening_job, index: true
      t.boolean :applied, default: false
      t.timestamps
    end
  end
end
