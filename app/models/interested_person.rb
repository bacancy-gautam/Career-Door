class InterestedPerson < ApplicationRecord
  belongs_to :opening_job
  belongs_to :user
end
