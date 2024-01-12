class CreateDashboardSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_schools do |t|
      t.string :name
      t.references :dashboard_district, null: false, foreign_key: true
      t.string :slug
      t.integer :qualtrics_code
      t.integer :dese_id
      t.boolean :is_hs

      t.timestamps
    end

    add_index :dashboard_schools, :dese_id, unique: true
  end
end
