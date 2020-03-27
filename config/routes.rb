# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  devise_for :companies, controllers: { 
    registrations: 'companies/registrations' }
  resources :companies, only: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :technologies
  resources :super_admins
  resources :resumes
end
