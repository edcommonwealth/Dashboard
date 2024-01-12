module Dashboard
  class Scale < ApplicationRecord
    belongs_to :measure, class_name: "Measure", foreign_key: :dashboard_measure_id
    has_many :survey_items
    has_many :survey_item_responses, through: :survey_items
    has_many :admin_data_items, class_name: "AdminDataItem", foreign_key: :admin_data_item_id

    def score(school:, academic_year:)
      @score ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] = begin
          items = []
          items << collect_survey_item_average(student_survey_items, school, academic_year)
          items << collect_survey_item_average(teacher_survey_items, school, academic_year)

          items.remove_blanks.average
        end
      end
      @score[[school, academic_year]]
    end

    scope :teacher_scales, lambda {
      where("scale_id LIKE 't-%'")
    }
    scope :student_scales, lambda {
      where("scale_id LIKE 's-%'")
    }

    private

    def collect_survey_item_average(survey_items, school, academic_year)
      survey_items.map do |survey_item|
        survey_item.score(school:, academic_year:)
      end.remove_blanks.average
    end

    def teacher_survey_items
      survey_items.teacher_survey_items
    end

    def student_survey_items
      survey_items.student_survey_items
    end
  end
end
