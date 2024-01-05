class CreateDashboardResponseRates < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_response_rates do |t|
      t.references :dashboard_subcategory, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.references :dashboard_academic_year, null: false, foreign_key: true
      t.float :school_response_rate
      t.float :teacher_response_rate

      t.timestamps
    end
  end
end
