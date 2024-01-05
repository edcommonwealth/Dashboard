module Dashboard
  class Score < ApplicationRecord
    belongs_to :dashboard_measure
    belongs_to :dashboard_school
    belongs_to :dashboard_academic_year
    belongs_to :dashboard_race

    NIL_SCORE = Score.new(average: nil, meets_teacher_threshold: false, meets_student_threshold: false,
                          meets_admin_data_threshold: false)

    enum group: {
      all_students: 0,
      race: 1,
      grade: 2,
      gender: 3
    }

    def in_zone?(zone:)
      return false if average.nil? || average.is_a?(Float) && average.nan?

      average.between?(zone.low_benchmark, zone.high_benchmark)
    end

    def blank?
      average.nil? || average.zero? || average.nan?
    end
  end
end
