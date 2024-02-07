# This migration comes from dashboard (originally 20240104174649)
class CreateDashboardIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_incomes do |t|
      t.string :designation
      t.string :slug

      t.timestamps
    end
  end
end
