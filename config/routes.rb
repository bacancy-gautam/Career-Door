# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions'
  }

  resources :companies, only: :index do
    resources :opening_jobs do
      get 'interested_people', on: :member
    end
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users do
    resources :opening_jobs do
      get 'jobs_list', on: :collection
      get 'apply', on: :member
      get 'interested', on: :member
    end
  end 
  resources :technologies
  resources :super_admins do
    resources :companies do
      get 'approve_company', on: :member
      get 'reject_company', on: :member
    end
  end
end
