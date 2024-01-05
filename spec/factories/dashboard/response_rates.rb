FactoryBot.define do
  factory :response_rate do
    subcategory { nil }
    school { nil }
    academic_year { nil }
    school_response_rate { 1.5 }
    teacher_response_rate { 1.5 }
  end
end
