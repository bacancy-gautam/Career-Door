class CreateCompaniesRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :companies_roles do |t|

      t.timestamps
    end
  end
end
