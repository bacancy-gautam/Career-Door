# frozen_string_literal: true

class CreateCompanyReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :company_reviews do |t|
      t.text :company_review
      t.integer :review_rating
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
