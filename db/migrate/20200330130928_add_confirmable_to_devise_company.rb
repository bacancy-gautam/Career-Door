# frozen_string_literal: true

# migration for adding confirmation field like confirmation token to company devise
class AddConfirmableToDeviseCompany < ActiveRecord::Migration[6.0]
  def up
    add_column :companies, :confirmation_token, :string
    add_column :companies, :confirmed_at, :datetime
    add_column :companies, :confirmation_sent_at, :datetime
    add_column :companies, :unconfirmed_email, :string
    add_index :companies, :confirmation_token, unique: true 
    User.update_all confirmed_at: DateTime.now
  end

  def down
    remove_columns :companies, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  end
end
