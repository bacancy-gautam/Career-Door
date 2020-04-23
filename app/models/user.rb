# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  attr_accessor :login_social
  validates_presence_of :firstname, :lastname, :username, :contact, :experience, :password, unless: :login_social
  validates :firstname, length: { maximum: 10 }, format: { multiline: true, with: /^[a-zA-Z]+$/, message: 'only alphabetic characters are allowed.' }
  validates :lastname, length: { maximum: 10 }, format: { multiline: true, with: /^[a-zA-Z]+$/, message: 'only alphabetic characters are allowed.' }
  validates :username, length: { maximum: 9 }, format: { multiline: true, with: /\w/, message: 'should not contain any two special character together or do not start with digit' }, unless: :login_social
  validates :email, presence: true, uniqueness: true, format: { with: /[a-z]+[\.]?[a-z]+[0-9]*\@[a-z]+.com/, message: 'Email should be unique or valid!' }
  validates :contact, uniqueness: true, format: { with: /\+[0-9]{2}\-[0-9]{3}[\s]*[0-9]{3}[\s]*[0-9]{4}/, message: 'contact has already been taken or format is invalid' }, unless: :login_social
  validates :password, presence: true, confirmation: true, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$\z/, message: 'Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character' }, unless: :login_social

  has_many :resumes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_many :interested_people, dependent: :destroy
  has_many :opening_jobs, through: :interested_people
  has_many :companies, dependent: :destroy
  has_many :company_reviews, dependent: :destroy
  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.provider = provider_data.provider
      user.uid = provider_data.uid
      user.email = provider_data.info.email
      user.firstname = provider_data.info.first_name
      user.lastname = provider_data.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.login_social = true
    end
  end
end
