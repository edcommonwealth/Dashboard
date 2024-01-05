class CreateDashboardDistricts < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_districts do |t|
      t.string :name
      t.string :slug, unique: true
      t.integer :qualtrics_code

      t.timestamps
    end
  end
end
