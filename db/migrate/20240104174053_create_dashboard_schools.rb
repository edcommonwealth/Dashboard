class CreateDashboardSchools < ActiveRecord::Migration[7.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.references :district, null: false, foreign_key: true
      t.text :description
      t.string :slug
      t.integer :qualtrics_code
      t.integer :dese_id
      t.boolean :is_hs

      t.timestamps
    end
  end
end
