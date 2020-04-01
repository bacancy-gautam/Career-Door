# frozen_string_literal: true

# migration for creatinf technology model
class CreateTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :technologies do |t|
      t.string :technology_name

      t.timestamps
    end
  end
end
