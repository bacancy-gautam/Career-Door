# frozen_string_literal: true

# crud operations for technology model
class TechnologiesController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_object, only: %i[new]
  before_action :display_all_technologies, only: %i[index]
  before_action :find_technology, only: %i[edit update show destroy]
  before_action :allowed_parameter, only: %i[create update]
  def create
    @new_technology = Technology.new(allowed_parameter)
    flash.alert = if @new_technology.save
                    redirect_to technologies_path
                    'technology saved'
                  else
                    render :new
                    'technology not saved'
                  end
  end

  def update
    flash.alert = if @added_technology.update(allowed_parameter)
                    redirect_to technologies_path
                    'technology updated'
                  else
                    render :edit
                    'technology is not updated'
                  end
  end

  def destroy
    flash.alert = if @added_technology.destroy
                    'technology deleted successfully'
                  else
                    'technology is not deleted'
    end
    redirect_to technologies_path
  end

  private

  def display_all_technologies
    @all_technologies = Technology.all
  end

  def initialize_object
    @new_technology = Technology.new
  end

  def allowed_parameter
    params.require(:technology).permit(:technology_name)
  end

  def find_technology
    @added_technology = Technology.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = 'Record not found'
    redirect_to technologies_path
  end
end