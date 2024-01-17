module Dashboard
  class ResponseRate < ApplicationRecord
    TEACHER_RATE_THRESHOLD = 24.5
    STUDENT_RATE_THRESHOLD = 24.5

    belongs_to :subcategory, class_name: "Subcategory", foreign_key: :dashboard_subcategory_id
    belongs_to :school, class_name: "School", foreign_key: :dashboard_school_id
    belongs_to :academic_year, class_name: "AcademicYear", foreign_key: :dashboard_academic_year_id

    def meets_student_threshold?
      student_response_rate >= 24.5
    end

    def meets_teacher_threshold?
      teacher_response_rate >= 24.5
    end
  end
end
