# frozen_string_literal: true

Rails.application.routes.draw do

  root to: 'home#index'
  devise_for :companies, controllers: { 
    registrations: 'companies/registrations' }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :companies, only: %i[index show] do
    resources :company_reviews
  end

  resources :technologies
  resources :super_admins
  resources :resumes
end
