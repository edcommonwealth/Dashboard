# This migration comes from dashboard (originally 20240104172921)
class CreateDashboardSurveyItems < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_survey_items do |t|
      t.string :survey_item_id
      t.string :prompt
      t.float :watch_low_benchmark
      t.float :growth_low_benchmark
      t.float :approval_low_benchmark
      t.float :ideal_low_benchmark
      t.references :dashboard_scale, null: false, foreign_key: true
      t.boolean :on_short_form

      t.timestamps
    end
  end
end
