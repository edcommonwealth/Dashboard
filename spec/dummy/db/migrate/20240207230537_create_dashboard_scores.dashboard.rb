# This migration comes from dashboard (originally 20240104183857)
class CreateDashboardScores < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_scores do |t|
      t.float :average
      t.boolean :meets_teacher_threshold
      t.boolean :meets_student_threshold
      t.boolean :meets_admin_data_threshold

      t.timestamps
    end
  end
end
