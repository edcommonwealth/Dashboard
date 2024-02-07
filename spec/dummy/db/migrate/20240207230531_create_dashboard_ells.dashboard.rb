# This migration comes from dashboard (originally 20240104174458)
class CreateDashboardElls < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_ells do |t|
      t.string :designation
      t.string :slug

      t.timestamps
    end
  end
end
