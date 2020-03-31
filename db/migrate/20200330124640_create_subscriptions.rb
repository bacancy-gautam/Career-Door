class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :company, index: true, null: true, foreign_key: true
      t.boolean :subscribed, default: false
      t.date :subscription_date
      t.timestamps
    end
  end
end
