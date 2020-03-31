# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[index show interested_people]
  before_action :find_company, only: %i[show approve_company reject_company]

  def index
    @companies = Company.all
  end

  def show
    @company_reviews = @company.company_reviews.order('created_at DESC')

    @avg_review = if @company_reviews.blank?
                    0
                  else
                    @company_reviews.average(:review_rating).round(2)
                  end
  end

  def approve_company
    if @company.update(approved: true)
      subscription = @company.subscription.build
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
