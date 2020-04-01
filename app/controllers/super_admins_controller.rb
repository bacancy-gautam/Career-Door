# frozen_string_literal: true

# super admins controller
class SuperAdminsController < ApplicationController
  def index
    @companies = Company.where(approved: false)
  end
end
