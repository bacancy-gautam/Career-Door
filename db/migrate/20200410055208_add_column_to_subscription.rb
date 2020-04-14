# frozen_string_literal: true

class AddColumnToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :un_subscribe_date, :date
  end
end
