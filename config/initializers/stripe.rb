# frozen_string_literal: true

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.stripe[:publishable_key],
  secret_key: Rails.application.credentials.stripe[:secret_key]
}
binding.pry
Stripe.api_key = Rails.configuration.stripe[:secret_key]
