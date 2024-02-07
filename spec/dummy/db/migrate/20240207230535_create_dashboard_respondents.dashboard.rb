# This migration comes from dashboard (originally 20240104181617)
class CreateDashboardRespondents < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_respondents do |t|
      t.references :dashboard_school, null: false, foreign_key: true
      t.references :dashboard_academic_year, null: false, foreign_key: true
      t.integer :total_students
      t.float :total_teachers
      t.integer :pk
      t.integer :k
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :six
      t.integer :seven
      t.integer :eight
      t.integer :nine
      t.integer :ten
      t.integer :eleven
      t.integer :twelve

      t.timestamps
    end

    add_index :dashboard_respondents, %i[dashboard_school_id dashboard_academic_year_id], unique: true
  end
end