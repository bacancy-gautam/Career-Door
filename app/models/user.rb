# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :resumes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD
  has_many :interested_people, dependent: :destroy
  has_many :opening_jobs, through: :interested_people
  has_many :companies, dependent: :destroy
  has_many :company_reviews, dependent: :destroy         
=======
  has_many :companies, dependent: :destroy
  has_many :company_reviews, dependent: :destroy         

>>>>>>> company review CRUD
  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end
<<<<<<< HEAD
=======

>>>>>>> company review CRUD
end
