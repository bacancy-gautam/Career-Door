class AppliedJobsController < ApplicationController
  before_action :allowed_parameters, only: :create
  def index
    @applied_jobs = AppliedJob.where(job_id: params[:id])
  end
  
  def new
    @applied_job = AppliedJob.new
  end

  def create
    @applied_job = current_user.applied_jobs.build(allowed_parameters)
    # @applied_job.opening_job.build(params[:id])
    @applied_job.opening_job_id = params[:id]
    if helpers.cgpa_valied?(@applied_job)
      if @applied_job.save
        redirect_to apply_user_opening_job_path, notice: 'applied!!'
      else
        render :new, alert: 'there is come error'
      end
    else
      render :new, alert: 'you are not eligible for this job.'
    end
  end

  def show
    @applied_jobs = AppliedJob.where(opening_job_id: params[:job_id])
  end
  
  def destroy
    @applied_job = AppliedJob.find_by(opening_job_id: params[:id], user_id: current_user)
    if @applied_job.destroy
      redirect_to apply_user_opening_job_path, alert: 'un applied'
    else
      render :show , alert: 'there is some error'
    end
  end
  private
  def allowed_parameters
    params.require(:applied_job).permit(:firstname, :lastname, :email ,:contact, :cgpa ,:years_of_experience ,:resume)
  end

end
