class CreateDashboardCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_categories do |t|
      t.string :name
      t.text :description
      t.string :slug, unique: true
      t.string :category_id
      t.string :short_description

      t.timestamps
    end
  end
end
