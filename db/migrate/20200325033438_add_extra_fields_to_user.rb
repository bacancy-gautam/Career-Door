# frozen_string_literal: true

class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :contact, :bigint
    add_column :users, :country, :string
    add_column :users, :zipcode, :integer
  end
end
