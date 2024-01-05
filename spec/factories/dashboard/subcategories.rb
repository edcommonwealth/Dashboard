FactoryBot.define do
  factory :subcategory do
    name { "MyString" }
    description { "MyText" }
    subcategory_id { "MyString" }
    dashboard_categories { nil }
  end
end
