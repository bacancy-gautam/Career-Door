class Technology < ApplicationRecord
  has_many :opening_jobs, dependent: :destroy
end
