# frozen_string_literal: true

class OpeningJobsController < ApplicationController
  before_action :find_job, only: %i[edit update destroy]
  before_action :find_company, only: %i[new create edit]
  def index
    @jobs = current_company.opening_jobs
  end

  def new
    @job = OpeningJob.new
  end

  def create
    @job = OpeningJob.new(jobs_params)
    if @job.save!
      redirect_to company_opening_jobs_path, notice: 'Job #been added!'
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @job.update(jobs_params)
      redirect_to company_opening_jobs_path, notice: 'Job updated'
    else
      render 'edit'
    end
  end

  def destroy
    @job.destroy
    redirect_to company_opening_jobs_path
  end

  private

  def jobs_params
    params.required(:opening_job).permit(:job_role, :company_id,
                                         :technology_id,
                                         :experience, :job_role,
                                         :description, :cgpa)
  end

  def find_job
    @job = OpeningJob.find(params[:id])
  end

  def find_company
    @company = Company.find(params[:company_id])
  end
end
