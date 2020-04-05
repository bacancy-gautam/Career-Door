# frozen_string_literal: true

class OpeningJobsController < ApplicationController
  before_action :find_job, only: %i[edit update destroy interested_people show
                                    open_close_post]
  before_action :find_company, only: %i[new create edit interested_people
                                        open_close_post]
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

  def interested_people
    @interested_people = @job.users
  end

  def jobs_list
    @jobs = OpeningJob.open_job
  end

  def apply
    if current_user.opening_jobs.where(id: params[:id]).blank?
      job = InterestedPerson.new(user_id: current_user.id,
                                 opening_job_id: params[:id],
                                 applied: true)
      if job.save!
        redirect_to jobs_list_user_opening_jobs_path, notice: 'Applied!'
      else
        flash[:alert] = 'Something went wrong'
        render 'new'
      end
    else
      job = current_user.interested_people.find_by(opening_job_id: params[:id])
      if job.applied?
        job.update(user_id: current_user.id,
                   opening_job_id: params[:id],
                   applied: false)
      else
        job.update(user_id: current_user.id,
                   opening_job_id: params[:id],
                   applied: true)
      end
      redirect_to jobs_list_user_opening_jobs_path, notice: 'Done!'
    end
  end

  def interested
    if current_user.opening_jobs.where(id: params[:id]).blank?
      job = InterestedPerson.new(user_id: current_user.id,
                                 opening_job_id: params[:id])
      if job.save!
        redirect_to jobs_list_user_opening_jobs_path, notice: 'Interest recorded!'
      else
        flash[:alert] = 'Something went wrong'
        render 'new'
      end
    else
      redirect_to jobs_list_user_opening_jobs_path
    end
  end

  def open_close_post
    @job.update(open: !@job.open)
    redirect_to company_opening_jobs_path, notice: "Done"
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
