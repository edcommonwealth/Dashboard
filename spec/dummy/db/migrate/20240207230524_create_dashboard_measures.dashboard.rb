# This migration comes from dashboard (originally 20240104170806)
class CreateDashboardMeasures < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_measures do |t|
      t.string :measure_id
      t.string :name
      t.references :dashboard_subcategory, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
