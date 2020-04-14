class AddAvatarsToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_attachment :companies, :avatar
  end
end
