# frozen_string_literal: true

# crate delete read operations for  resumes
class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resume, only: %i[edit update destroy]

  def index
    @resumes = current_user.resumes
  end

  def new
    @new_resume = Resume.new
  end

  def create
    @new_resume = current_user.resumes.build(allowed_parameters)
    if @new_resume.save
      redirect_to resumes_path, notice: 'Resume saved'
    else
      render :new, alert: 'Resume not saved'
    end
  end

  def update
    if @resume.update(allowed_parameters)
      redirect_to resumes_path, notice: 'Resume updated'
    else
      render :edit, alert: 'Resume not updated'
    end
  end

  def destroy
    if @resume.destroy
      redirect_to resumes_path, notice: 'resume deleted'
    else
      render :index, alert: 'resume is not deleted'
    end
  end

  private

  def find_resume
    @resume = current_user.resumes.find(params[:id])
  end

  def allowed_parameters
    params.require(:resume).permit(:resume_name, :file)
  end
end
