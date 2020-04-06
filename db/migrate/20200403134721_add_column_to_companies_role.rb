class AddColumnToCompaniesRole < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies_roles, :company, foreign_key: true
    add_reference :companies_roles, :role, foreign_key: true
  end
end
