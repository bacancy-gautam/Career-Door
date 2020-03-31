# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  
  validates :firstname, presence: true, length: { maximum: 10},format: { multiline: true, with: /^[a-zA-Z]+$/, message: 'only alphabetic characters are allowed.'}
  validates :lastname, presence: true, length: { maximum: 10}, format: { multiline: true, with: /^[a-zA-Z]+$/, message: 'only alphabetic characters are allowed.'}
  validates :username, presence: true, length: { maximum: 8}, format: { multiline: true, with: /\w/, message: 'should not contain any two special character together or do not start with digit' }
  validates :email, presence: true, uniqueness: true, format: { with: /[a-z]+[\.]?[a-z]+[0-9]*\@[a-z]+.com/, message: 'Email should be unique or valid!' }
  validates :contact, presence: true, uniqueness: true, format: { with: /\+[0-9]{2}\-[0-9]{3}[\s]*[0-9]{3}[\s]*[0-9]{4}/, message: 'contact has already been taken or format is invalid' }
  validates :experience, presence: true
  validates :password, presence: true, confirmation: true, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$\z/, message: 'Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character' }
  validates :password_confirmation, presence: true

  has_many :resumes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :confirmable, :recoverable, :rememberable,
         :validatable

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end
  
end
