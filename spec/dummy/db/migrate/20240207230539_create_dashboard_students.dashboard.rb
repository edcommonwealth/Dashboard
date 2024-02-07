# This migration comes from dashboard (originally 20240104184053)
class CreateDashboardStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_students do |t|
      t.string :lasid
      t.string :response_id

      t.timestamps
    end
  end
end
