# frozen_string_literal: true

# crud operations on CompanyReview Model
class CompanyReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :initialize_object, only: %i[new create]
  before_action :find_company_reviews, only: %i[edit show update destroy]
  before_action :allowed_parameters, only: %i[create update]

  def create
    @company_review = @company.company_reviews.new(allowed_parameters.merge(user_id: current_user.id))
    flash.alert = if @company_review.save
                    redirect_to company_path(@company)
                    'Review saved successfully'
                  else
                    render :new
                    'Review not create successfully'
                  end
  end

  def new; end

  def show; end

  def update
    flash.alert = if @company_review.update(allowed_parameters)
                    redirect_to company_path(@company)
                    'Review updated successfully'
                  else
                    render :edit
                    'Review not updated successfully'
                  end
  end

  def destroy
    flash.alert = if @company_review.destroy
                    redirect_to company_reviews_path
                    'Review deleted successfully'
                  else
                    render :index
                    'Review not deleted'
                  end
  end

  private

  def show_all_company_reviews
    @company_reviews = @company.company_reviews.where(user_id: current_user.id)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def initialize_object
    @company_review = @company.company_reviews.new
  end

  def find_company_reviews
    @company_review = CompanyReview.find(params[:id])
  end

  def allowed_parameters
    params.require(:company_review).permit(:company_review, :review_rating)
  end
end
