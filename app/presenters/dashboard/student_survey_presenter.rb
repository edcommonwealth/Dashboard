# frozen_string_literal: true

module Dashboard
  class StudentSurveyPresenter < DataItemPresenter
    attr_reader :survey_items

    def initialize(measure_id:, survey_items:, has_sufficient_data:, school:, academic_year:)
      super(measure_id:, has_sufficient_data:, school:, academic_year:)
      @survey_items = survey_items
    end

    def title
      "Student survey"
    end

    def id
      "student-survey-items-#{@measure_id}"
    end

    def reason_for_insufficiency
      "low response rate"
    end

    def descriptions_and_availability
      survey_items.reject do |survey_item|
        question_id = survey_item.survey_item_id.split("-")[2]
        if question_id.present?
          question_id.starts_with?("es")
        else
          false
        end
      end.map(&:description)
    end
  end
end
