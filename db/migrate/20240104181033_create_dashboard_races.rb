class CreateDashboardRaces < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_races do |t|
      t.string :designation
      t.integer :qualtrics_code
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
