# frozen_string_literal: true

# technology model
class Technology < ApplicationRecord
  validates :technology_name, presence: true, format: { with: /[a-zA-Z]/, message: 'only alphabetic characters are allowed.'}
  has_many :opening_jobs, dependent: :destroy
end
