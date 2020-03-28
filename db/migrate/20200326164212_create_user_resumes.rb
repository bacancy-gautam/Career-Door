class CreateUserResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_resumes do |t|
      t.string :name
      t.string :resume

      t.timestamps
    end
  end
end
