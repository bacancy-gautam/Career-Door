class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: :index
end
