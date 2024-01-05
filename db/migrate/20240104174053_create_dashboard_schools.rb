class CreateDashboardSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_schools do |t|
      t.string :name
      t.references :dashboard_district_id, null: false, foreign_key: true
      t.text :description
      t.string :slug, unique: true
      t.integer :qualtrics_code
      t.integer :dese_id
      t.boolean :is_hs

      t.timestamps
    end
  end
end
