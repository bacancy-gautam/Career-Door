# frozen_string_literal: true

# super admins controller
class SuperAdminsController < ApplicationController
  before_action :authenticate_user!, :check_user

  def index
    @companies = Company.where(approved: false)
  end

  def check_user
    redirect_to root_path if current_user.has_role?(:user)
  end
end
