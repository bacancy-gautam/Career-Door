# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true
end
