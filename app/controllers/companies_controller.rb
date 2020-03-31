# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[index interested_people]
  before_action :find_company, only: %i[approve_company reject_company]

  def index
    diff = Time.now.utc - current_company.subscription.created_at
    @remaining_days = ((15.days.seconds - diff) / 1.day).to_i
  rescue StandardError
    @remaining_days = 0
  end

  def approve_company
    if @company.update(approved: true)
      subscription = @company.build_subscription
      redirect_to super_admins_path, notice: 'Approved!' if subscription.save!
    end
  end

  def reject_company
    redirect_to super_admins_path, notice: 'Rejected!' if @company.destroy
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end
end
