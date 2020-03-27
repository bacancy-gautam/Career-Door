# frozen_string_literal: true

class OpeningJob < ApplicationRecord
  belongs_to :company
  belongs_to :technology
  has_many :interested_people
  has_many :users, through: :interested_people
end
