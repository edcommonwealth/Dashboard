FactoryBot.define do
  factory :score do
    average { 1.5 }
    meets_teacher_threshold { false }
    meets_student_threshold { false }
    meets_admin_data_threshold { false }
  end
end
