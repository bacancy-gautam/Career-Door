class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.belongs_to :company, index: true
      t.string :msg
      t.timestamps
    end
  end
end
