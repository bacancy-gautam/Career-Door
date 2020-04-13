# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[index interested_people]
  before_action :find_company, only: %i[approve_company reject_company show 
                                        unapprove_company]

  def index
    @companies = Company.all
    diff = Time.now.utc - current_company.subscription.created_at
    @remaining_days = ((15.days.seconds - diff) / 1.day).to_i
  rescue StandardError
    @remaining_days = 0
  end

  def show
    @company_reviews = @company.company_reviews.order('created_at DESC')

    @avg_review = if @company_reviews.blank?
                    0
                  else
                    @company_reviews.average(:review_rating).round(2)
                  end
                  
    @latlong = Geocoder.search("#{@company.city},
                                #{CS.states(@company.country.to_sym)[@company.state.to_sym]},
                                #{CS.countries[@company.country.to_sym]}").first.coordinates
    # @longitude = Geocoder.search("#{@company.city}, #{@company.state},
    #                              #{@company.country}").first.coordinates[1]
    # @map = GMaps.new(div: '#map', lat: -12.043333, lng: -77.028333)
    # binding.pry
  end

  def unapprove_company
    @company.update(approved: false)
    @subscriptions = Subscription.all
      # redirect_to super_admins_path, notice: 'Unapproved!'
  end

  def approve_company
    if @company.update(approved: true)
      if @company.subscription.blank?
        subscription = @company.build_subscription 
        flash[:notice] = 'Approved!' if subscription.save!
      else
        @subscriptions = Subscription.all
      end
      respond_to do |format|
        format.js
        format.html {redirect_to super_admins_path}
      end
    end
  end

  def reject_company
    redirect_to super_admins_path, notice: 'Rejected!' if @company.destroy
  end

  def chat
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end
end
