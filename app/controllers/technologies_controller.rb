# frozen_string_literal: true

# crud operations for technology model
class TechnologiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_technology, only: %i[edit update show destroy]

  def index
    @all_technologies = Technology.all
  end

  def new
    @new_technology = Technology.new
  end

  def create
    @new_technology = Technology.new(allowed_parameter)
    if @new_technology.save
      redirect_to technologies_path, notice: 'technology saved'
    else
      render :new, alert: 'technology not saved'
    end
  end

  def update
    if @added_technology.update(allowed_parameter)
      redirect_to technologies_path, notice: 'technology updated'
    else
      render :edit, alert: 'technology not updated'
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

  def allowed_parameter
    params.require(:technology).permit(:technology_name)
  end

  def find_technology
    @added_technology = Technology.find(params[:id])
  end
end
