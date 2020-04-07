# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: "https://carrier-door.herokuapp.com"

  root to: 'home#index'
  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions',
    confirmations: 'companies/confirmations'
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users do
    resources :opening_jobs do
      get 'jobs_list', on: :collection
      get 'apply', on: :member
      get 'interested', on: :member
    end
  end

  resources :companies, only: %i[index show] do
    resources :charges, on: :member
    resources :company_reviews
    resources :opening_jobs do
      member do
        get 'interested_people'
        get 'open_close_post'
      end
    end
  end

  resources :technologies
  resources :super_admins do
    get 'charges/index', on: :collection
    member do
      get 'companies/approve_company'
      get 'companies/reject_company'
    end
  end
  resources :resumes
end
