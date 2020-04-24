class AddCityToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    add_column :companies, :country, :string
  end
end
