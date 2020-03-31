# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :companies, controllers: {
    registrations: 'companies/registrations',
    sessions: 'companies/sessions'
  }

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

  resources :companies, only: %i[index show] do
    resources :company_reviews
    resources :opening_jobs do
      get 'interested_people', on: :member
    end
  end

  resources :technologies
  resources :super_admins
  resources :resumes
end
