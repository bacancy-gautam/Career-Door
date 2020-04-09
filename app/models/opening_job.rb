# frozen_string_literal: true

class OpeningJob < ApplicationRecord
  validates :experience, presence: true, format: { multiline: true, with: /^[0-9](\.[0-9]+)?$/, message: 'only digits are allowed' }
  validates :job_role, presence: true, format: { multiline: true, with: /^[a-zA-Z]+$/, message: 'only alphabetic characters are allowed.' }
  validates :description, presence: true, length: { maximum: 100 }
  validates :cgpa, presence: true, format: { multiline: true, with: /^[0-9](\.[0-9]+)?$/, message: 'only digits are allowed' }

  belongs_to :company
  has_many :interested_people, dependent: :destroy
  has_many :users, through: :interested_people
  
  serialize :technologies, Array
  scope :open_job, -> { where(open: true) }

  after_create :notify_user
  before_save do
    self.technology_id.gsub!(/[\[\]\"]/,"") if attribute_present?("technology_id")
  end
  def notify_user
    users = User.all
    users.each do |user|
      NotifyUsersMailer.notify_users_for_new_job(user, self).deliver
    end
  end

end
