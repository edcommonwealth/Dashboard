class CreateDashboardSubcategories < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_subcategories do |t|
      t.string :name
      t.text :description
      t.string :subcategory_id
      t.references :dashboard_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
