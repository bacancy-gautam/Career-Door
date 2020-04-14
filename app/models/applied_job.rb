# frozen_string_literal: true

class AppliedJob < ApplicationRecord
  belongs_to :user
  belongs_to :opening_job
end
