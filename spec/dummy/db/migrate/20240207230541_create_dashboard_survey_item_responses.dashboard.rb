# This migration comes from dashboard (originally 20240104192128)
class CreateDashboardSurveyItemResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :dashboard_survey_item_responses do |t|
      t.integer :likert_score
      t.references :dashboard_school, null: false, foreign_key: true
      t.references :dashboard_survey_item, null: false, foreign_key: true
      t.references :dashboard_academic_year, null: false, foreign_key: true
      t.references :dashboard_student, foreign_key: true
      t.references :dashboard_gender,  foreign_key: true
      t.references :dashboard_income,  foreign_key: true
      t.references :dashboard_ell,  foreign_key: true
      t.references :dashboard_sped, foreign_key: true
      t.string :response_id
      t.integer :grade
      t.datetime :recorded_date

      t.timestamps
    end
    add_index :dashboard_survey_item_responses, %i[dashboard_school_id dashboard_academic_year_id]
    add_index :dashboard_survey_item_responses,
              %i[response_id dashboard_school_id dashboard_academic_year_id dashboard_survey_item_id], unique: true
  end
end
