FactoryBot.define do
  factory :survey_item do
    survey_item_id { "MyString" }
    prompt { "MyString" }
    watch_low_benchmark { 1.5 }
    growth_low_benchmark { 1.5 }
    approval_low_benchmark { 1.5 }
    ideal_low_benchmark { 1.5 }
    dashboard_scale { nil }
    on_short_form { false }
  end
end
