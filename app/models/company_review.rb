# frozen_string_literal: true

class CompanyReview < ApplicationRecord
  validates :company_review, presence: true
  validates :review_rating, presence: true
  belongs_to :user
  belongs_to :company
end
