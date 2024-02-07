# This migration comes from dashboard (originally 20240104173424)
class CreateDashboardAdminDataItems < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_admin_data_items do |t|
      t.string :admin_data_item_id
      t.string :description
      t.float :watch_low_benchmark
      t.float :growth_low_benchmark
      t.float :approval_low_benchmark
      t.float :ideal_low_benchmark
      t.boolean :hs_only_item
      t.references :dashboard_scale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
