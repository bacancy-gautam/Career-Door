# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @companies = Company.search(params[:search])
  end

  def applied_job_list
    @jobs = current_user.opening_jobs
  end
end
