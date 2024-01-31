module Dashboard
  class StudentRace < ApplicationRecord
    belongs_to :student, optional: true, class_name: "Student", foreign_key: :dashboard_student_id
    belongs_to :race, optional: true, class_name: "Race", foreign_key: :dashboard_race_id
  end
end
