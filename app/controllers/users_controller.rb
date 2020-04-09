# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.search(params[:email])
  end
end
