class CreateDashboardGenders < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_genders do |t|
      t.integer :qualtrics_code
      t.string :designation

      t.timestamps
    end
  end
end
