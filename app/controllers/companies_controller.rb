# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[index interested_people]
  before_action :find_company, only: %i[approve_company reject_company]
  def approve_company
    if @company.update(approved: true)
      subscription = Subscription.new(company_id: @company.id)
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
