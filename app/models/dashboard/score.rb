module Dashboard
  class Score < ApplicationRecord
    belongs_to :measure, class_name: "Measure", foreign_key: :dashboard_measure_id
    belongs_to :school, class_name: "School", foreign_key: :dashboard_school_id
    belongs_to :academic_year, class_name: "AcademicYear", foreign_key: :dashboard_academic_year_id

    NIL_SCORE = Score.new(average: nil, meets_teacher_threshold: false, meets_student_threshold: false,
                          meets_admin_data_threshold: false)

    def in_zone?(zone:)
      return false if average.nil? || average.is_a?(Float) && average.nan?

      average.between?(zone.low_benchmark, zone.high_benchmark)
    end

    def blank?
      average.nil? || average.zero? || average.nan?
    end
  end
end
