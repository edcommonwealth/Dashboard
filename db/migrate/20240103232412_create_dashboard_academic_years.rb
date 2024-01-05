class CreateDashboardAcademicYears < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_academic_years do |t|
      t.string :range

      t.timestamps
    end

    add_index :dashboard_academic_years, :range
  end
end
