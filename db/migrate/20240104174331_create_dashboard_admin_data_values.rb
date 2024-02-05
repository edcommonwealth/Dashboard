class CreateDashboardAdminDataValues < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_admin_data_values do |t|
      t.float :likert_score
      t.references :dashboard_school, null: false, foreign_key: true
      t.references :dashboard_admin_data_item, null: false, foreign_key: true
      t.references :dashboard_academic_year, null: false, foreign_key: true

      t.timestamps
    end

    add_index :dashboard_admin_data_values,
              %i[dashboard_admin_data_item_id dashboard_school_id dashboard_academic_year_id], unique: true
  end
end
