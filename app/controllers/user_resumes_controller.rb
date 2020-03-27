# frozen_string_literal: true

# crate delete read operations for user resumes
class UserResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :show_all_resumes, only: :index
  before_action :initialize_new_object, only: :new
  before_action :find_resume, only: %i[edit update destroy]

  def create
    @new_resume = UserResume.new(allowed_parameters)
    @new_resume.user_id = current_user.id
    flash.alert = if @new_resume.save
                    redirect_to user_resumes_path
                    'resume saved successfully'
                  else
                    render :new
                    'resume not saved sucessfully'
                  end
  end

  def update
    flash.alert = if @resume.update(allowed_parameters)
                    redirect_to user_resumes_path
                    'Resume updated successfully'
                  else
                    render :edit
                    'Resume not updated successfully'
                  end
  end

  def destroy
    flash.alert = if @resume.destroy
                    redirect_to user_resumes_path
                    'resume deleted successfully'
                  else
                    render :index
                    'resume not deleted successfully'
                  end
  end

  private

  def show_all_resumes
    @resumes = UserResume.where(user_id: current_user.id)
  end

  def initialize_new_object
    @new_resume = UserResume.new
  end

  def find_resume
    @resume = UserResume.find(params[:id])
  end

  def allowed_parameters
    params.require(:user_resume).permit(:resume_name, :resume)
  end
end
