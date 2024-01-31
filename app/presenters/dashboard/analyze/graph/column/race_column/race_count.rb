# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module RaceColumn
          module RaceCount
            def type
              :student
            end

            def n_size(year_index)
              SurveyItemResponse.joins("JOIN dashboard_student_races on dashboard_survey_item_responses.dashboard_student_id = dashboard_student_races.dashboard_student_id JOIN dashboard_students on dashboard_students.id = dashboard_student_races.dashboard_student_id").where(
                school:, academic_year: academic_years[year_index],
                survey_item: measure.student_survey_items
              ).where("dashboard_student_races.dashboard_race_id": race.id).select(:response_id).distinct.count
            end
          end
        end
      end
    end
  end
end
