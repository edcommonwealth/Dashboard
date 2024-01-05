class CreateDashboardScales < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_scales do |t|
      t.string :scale_id
      t.references :dashboard_measure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
