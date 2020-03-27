# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  devise_for :companies, controllers: { 
    registrations: 'companies/registrations',
    sessions: 'companies/sessions'
  }
  resources :companies, only: :index do
    resources :opening_jobs
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :technologies
  resources :super_admins
end
