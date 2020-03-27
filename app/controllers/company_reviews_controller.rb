# frozen_string_literal: true

# crud operations on CompanyReview Model
class CompanyReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :initialize_new_object, only: :new
  before_action :find_company_review, only: %i[edit show update destroy]
  before_action :company_review_params, only: %i[create update]

  def create
    @company_review = CompanyReview.new(company_review_params)
    @company_review.user_id = current_user.id
    @company_review.company_id = @company.id
    flash.alert = if @company_review.save
                    redirect_to edit_company_company_review_path(@company.id, @company_review.id)
                    'Review saved successfully'
                  else
                    render :new
                    'Review not create successfully'
                  end
  end

  def new; end

  def update
    flah.alert =  if @company_review.update(company_review_params)
                    redirect_to edit_company_company_review_path(@company_review.id)
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
    @company_review = company_reviews.where(user_id: current_user.id)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def initialize_new_object
    @company_review = @company.company_reviews.new
  end

  def find_company_review
    @company_review = CompanyReview.find(params[:id])
  end

  def company_review_params
    params.require(:company_review).permit(:company_review, :review_rating)
  end
end
