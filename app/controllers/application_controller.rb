# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  def after_sign_in_path_for(_resource)
    (current_user.has_role? :super_admin) ? super_admins_path : root_path
  end

  protected

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, stataus: 404
    nil
  end
end
