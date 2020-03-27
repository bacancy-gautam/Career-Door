# frozen_string_literal: true

# resume model
class Resume < ApplicationRecord
  belongs_to :user
  has_one_attached :file
end
