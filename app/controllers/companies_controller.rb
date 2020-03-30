# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: %i[index interested_people]
end
