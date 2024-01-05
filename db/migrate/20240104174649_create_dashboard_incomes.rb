class CreateDashboardIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_incomes do |t|
      t.string :designation
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
