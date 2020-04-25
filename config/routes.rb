# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cities, only: :index
  resources :states, only: :index
  default_url_options host: 'https://career-doorr.herokuapp.com'
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
    get 'home/applied_job_list', on: :member
    resources :opening_jobs do
      get 'jobs_list', on: :collection
      get 'applied_jobs/new', to: 'applied_jobs#new',on: :member
      post '/applied_jobs', to: 'applied_jobs#create',on: :member, as: 'applied'
      delete '/applied_jobs', to: 'applied_jobs#destroy',on: :member, as: 'un_apply'
      get 'apply', on: :member
      get 'interested', on: :member
    end
  end

  
  resources :companies, only: %i[index show] do
    get 'chat', on: :member
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
      get 'companies/unapprove_company'
    end
  end
  resources :resumes
  get '/applied_jobs/:job_id', to: 'applied_jobs#show', as:'applied_candidates'
  resources :messages do
    get 'new_message', on: :member
  end
end
