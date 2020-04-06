# frozen_string_literal: true

class ChargesController < ApplicationController
  def index
    @subscriptions = Subscription.all
  end

  def create
    @amount = 500
    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })
    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: @amount,
                                     description: 'Rails Stripe customer',
                                     currency: 'inr'
                                   })
    current_company.subscription.update(subscribed: true, subscription_date: DateTime.now)
  rescue Stripe::CardError => e
    redirect_to new_company_charge_path(params(:id)), error: e.message
  end
end
