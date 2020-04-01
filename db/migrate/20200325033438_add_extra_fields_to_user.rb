# frozen_string_literal: true

class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :contact, :string
    add_column :users, :experience, :string
    add_column :users, :years_of_experience, :integer, default: 0
  end
end
