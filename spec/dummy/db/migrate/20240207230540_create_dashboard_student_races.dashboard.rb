# This migration comes from dashboard (originally 20240104190838)
class CreateDashboardStudentRaces < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_student_races do |t|
      t.references :dashboard_student, null: false, foreign_key: true
      t.references :dashboard_race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
