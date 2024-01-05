FactoryBot.define do
  factory :school do
    name { "MyString" }
    dashboard_district { nil }
    description { "MyText" }
    slug { "MyString" }
    qualtrics_code { 1 }
    dese_id { 1 }
    is_hs { false }
  end
end
