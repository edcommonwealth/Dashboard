FactoryBot.define do
  factory :admin_data_item do
    admin_data_item_id { "MyString" }
    description { "MyString" }
    watch_low_benchmark { 1.5 }
    growth_low_benchmark { 1.5 }
    approval_low_benchmark { 1.5 }
    ideal_low_benchmark { 1.5 }
    hs_only_item { false }
    dashboard_scale { nil }
  end
end
