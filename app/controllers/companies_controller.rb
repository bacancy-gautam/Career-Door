# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :authenticate_company!, only: %i[index interested_people show]

  def index
    @companies = Company.all
  end

  def show
    @company_reviews = CompanyReview.where(company_id: @company.id).order('created_at DESC')

    @avg_review = if @company_reviews.blank?
                    0
                  else
                    @company_reviews.average(:review_rating).round(2)
                  end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
end
