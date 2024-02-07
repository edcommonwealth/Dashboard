# This migration comes from dashboard (originally 20240104183934)
class CreateDashboardSpeds < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_speds do |t|
      t.string :designation
      t.string :slug

      t.timestamps
    end
  end
end
