FactoryBot.define do
  factory :admin_data_value do
    likert_score { 1.5 }
    dashboard_school { nil }
    dashboard_admin_data_item { nil }
    dashboard_academic_year { nil }
  end
end
