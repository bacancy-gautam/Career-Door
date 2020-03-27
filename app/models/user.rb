# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :resumes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end
  
end
