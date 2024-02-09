class AddUniqueIndexToDashboardAcademicYear < ActiveRecord::Migration[7.1]
  def change
    add_index :dashboard_academic_years, :range, unique: true
  end
end
