# frozen_string_literal: true

# resume model
class Resume < ApplicationRecord
  validates :resume_name, presence: true
  validates :file, presence: true
  
  belongs_to :user
  has_one_attached :file
end
