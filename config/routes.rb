# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions',
    confirmations: 'companies/confirmations'
  }
  resources :companies, only: [:index]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
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
    collection do
      resources :charges, only: :index
      resources :companies do
        member do
          get 'approve_company'
          get 'reject_company'
        end
      end
    end
  end
  resources :super_admins
  resources :resumes
end
