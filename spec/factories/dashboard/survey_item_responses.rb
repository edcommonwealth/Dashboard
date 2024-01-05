FactoryBot.define do
  factory :survey_item_response do
    likert_score { 1 }
    dashboard_school { nil }
    dashboard_survey_item { nil }
    dashboard_academic_year { nil }
    dashboard_student { nil }
    dashboard_gender { nil }
    dashboard_income { nil }
    dashboard_ell { nil }
    dashboard_sped { nil }
    response_id { "MyString" }
    grade { 1 }
    recorded_date { "2024-01-04 11:21:28" }
  end
end
