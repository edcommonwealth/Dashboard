# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module ScoreForRace
          def score(year_index)
            academic_year = academic_years[year_index]
            meets_student_threshold = sufficient_student_responses?(academic_year:)
            return Score::NIL_SCORE unless meets_student_threshold

            survey_items = measure.student_survey_items

            averages = SurveyItemResponse.averages_for_race(school, academic_year, race)
            average = bubble_up_averages(averages:).round(2)

            Score.new(average:,
                      meets_teacher_threshold: false,
                      meets_student_threshold:,
                      meets_admin_data_threshold: false)
          end

          def bubble_up_averages(averages:)
            measure.student_scales.map do |scale|
              scale.survey_items.map do |survey_item|
                averages[survey_item.id]
              end.remove_blanks.average
            end.remove_blanks.average
          end

          def sufficient_student_responses?(academic_year:)
            return false unless measure.subcategory.response_rate(school:, academic_year:).meets_student_threshold?

            number_of_students_for_a_racial_group = SurveyItemResponse.joins("JOIN dashboard_student_races on dashboard_survey_item_responses.dashboard_student_id = dashboard_student_races.dashboard_student_id JOIN dashboard_students on dashboard_students.id = dashboard_student_races.dashboard_student_id").where(
              school:, academic_year:
            ).where("dashboard_student_races.dashboard_race_id": race.id).distinct.pluck(:dashboard_student_id).count
            number_of_students_for_a_racial_group >= 10
          end
        end
      end
    end
  end
end
