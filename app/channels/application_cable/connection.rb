# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_company

    def connect
      self.current_company = find_verified_user
    end

    private
      def find_verified_user
        if current_company = User.find_by(id: cookies.signed[:user_id])
          current_company
        else
          reject_unauthorized_connection
        end
      end
  end
end
