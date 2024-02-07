# This migration comes from dashboard (originally 20240104181033)
class CreateDashboardRaces < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_races do |t|
      t.string :designation
      t.integer :qualtrics_code
      t.string :slug

      t.timestamps
    end
  end
end
