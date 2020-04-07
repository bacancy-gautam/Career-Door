# frozen_string_literal: true

class Company < ApplicationRecord
  rolify

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :website, presence: true, format: { multiline: true, with: %r{^(http://www\.|https://www\.|http://|https://)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?$}, message: 'invalid url' }
  validates :address, presence: true
  validates :whichtype, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /[a-z]+[\.]?[a-z]+[0-9]*\@[a-z]+.com/, message: 'Email should be unique or valid!' }
  validates :mobile, presence: true, uniqueness: true, format: { with: /\+[0-9]{2}\-[0-9]{3}[\s]*[0-9]{3}[\s]*[0-9]{4}/, message: 'contact has already been taken or format is invalid' }
  validates :password, presence: true, confirmation: true, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$\z/, message: 'Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character' }, if: -> { new_record? || !password.nil? } # validates :password_confirmation, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :opening_jobs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one :subscription, dependent: :destroy
  has_many :company_reviews, dependent: :destroy

  after_create :assign_default_role

  def assign_default_role
    add_role(:company) if roles.blank?
  end

  def self.search(search)
    if search
      Company.where("lower(name) LIKE ?", "%#{search.downcase}%")
    else
      Company.all
    end
  end
end
