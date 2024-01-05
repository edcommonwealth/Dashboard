class CreateDashboardElls < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_ells do |t|
      t.string :designation
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
