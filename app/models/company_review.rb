# frozen_string_literal: true

class CompanyReview < ApplicationRecord
  belongs_to :user
  belongs_to :company
end