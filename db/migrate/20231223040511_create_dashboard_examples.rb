class CreateDashboardExamples < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_examples do |t|
      t.string :text
      t.text :body

      t.timestamps
    end
  end
end
