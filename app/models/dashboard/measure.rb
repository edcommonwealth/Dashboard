module Dashboard
  class Measure < ApplicationRecord
    belongs_to :dashboard_subcategory
    has_one :dashboard_category, through: :dashboard_subcategory
    has_many :dashboard_scales
    has_many :dashboard_admin_data_items, through: :scales
    has_many :dashboard_survey_items, through: :scales
    has_many :dashboard_survey_item_responses, through: :survey_items

    def none_meet_threshold?(school:, academic_year:)
      @none_meet_threshold ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] = !sufficient_survey_responses?(school:, academic_year:)
      end

      @none_meet_threshold[[school, academic_year]]
    end

    def teacher_survey_items
      @teacher_survey_items ||= survey_items.teacher_survey_items
    end

    def student_survey_items
      @student_survey_items ||= survey_items.student_survey_items
    end

    def student_survey_items_with_sufficient_responses(school:, academic_year:)
      @student_survey_items_with_sufficient_responses ||= SurveyItem.where(id: SurveyItem.joins("inner join survey_item_responses on survey_item_responses.survey_item_id = survey_items.id")
                                        .student_survey_items
                                        .where("survey_item_responses.school": school,
                                               "survey_item_responses.academic_year": academic_year,
                                               "survey_item_responses.survey_item_id": survey_items.student_survey_items,
                                               "survey_item_responses.grade": school.grades(academic_year:))
                                        .group("survey_items.id")
                                        .having("count(*) >= 10")
                                        .count.keys)
    end

    def teacher_scales
      @teacher_scales ||= scales.teacher_scales
    end

    def student_scales
      @student_scales ||= scales.student_scales
    end

    def includes_teacher_survey_items?
      @includes_teacher_survey_items ||= teacher_survey_items.any?
    end

    def includes_student_survey_items?
      @includes_student_survey_items ||= student_survey_items.any?
    end

    def includes_admin_data_items?
      @includes_admin_data_items ||= admin_data_items.any?
    end

    def score(school:, academic_year:)
      @score ||= Hash.new do |memo, (school, academic_year)|
        next Score::NIL_SCORE if incalculable_score(school:, academic_year:)

        scores = collect_averages_for_teacher_student_and_admin_data(school:, academic_year:)
        average = scores.flatten.compact.remove_blanks.average.round(2)

        next Score::NIL_SCORE if average.nan?

        memo[[school, academic_year]] = scorify(average:, school:, academic_year:)
      end
      @score[[school, academic_year]]
    end

    def student_score(school:, academic_year:)
      @student_score ||= Hash.new do |memo, (school, academic_year)|
        meets_student_threshold = sufficient_student_data?(school:, academic_year:)
        average = student_average(school:, academic_year:).round(2) if meets_student_threshold
        memo[[school, academic_year]] = scorify(average:, school:, academic_year:)
      end

      @student_score[[school, academic_year]]
    end

    def teacher_score(school:, academic_year:)
      @teacher_score ||= Hash.new do |memo, (school, academic_year)|
        meets_teacher_threshold = sufficient_teacher_data?(school:, academic_year:)
        average = teacher_average(school:, academic_year:).round(2) if meets_teacher_threshold
        memo[[school, academic_year]] = scorify(average:, school:, academic_year:)
      end

      @teacher_score[[school, academic_year]]
    end

    def admin_score(school:, academic_year:)
      @admin_score ||= Hash.new do |memo, (school, academic_year)|
        meets_admin_threshold = sufficient_admin_data?(school:, academic_year:)
        average = admin_data_averages(school:, academic_year:).average.round(2) if meets_admin_threshold
        memo[[school, academic_year]] = scorify(average:, school:, academic_year:)
      end

      @admin_score[[school, academic_year]]
    end

    def warning_low_benchmark
      1
    end

    def watch_low_benchmark
      @watch_low_benchmark ||= benchmark(:watch_low_benchmark)
    end

    def growth_low_benchmark
      @growth_low_benchmark ||= benchmark(:growth_low_benchmark)
    end

    def approval_low_benchmark
      @approval_low_benchmark ||= benchmark(:approval_low_benchmark)
    end

    def ideal_low_benchmark
      @ideal_low_benchmark ||= benchmark(:ideal_low_benchmark)
    end

    def sufficient_admin_data?(school:, academic_year:)
      any_admin_data_collected?(school:, academic_year:)
    end

    def benchmark(name)
      averages = []
      averages << student_survey_items.first.send(name) if includes_student_survey_items?
      averages << teacher_survey_items.first.send(name) if includes_teacher_survey_items?
      (averages << admin_data_items.map(&name)).flatten! if includes_admin_data_items?
      averages.average
    end

    private

    def any_admin_data_collected?(school:, academic_year:)
      @any_admin_data_collected ||= Hash.new do |memo, (school, academic_year)|
        total_collected_admin_data_items =
          admin_data_items.map do |admin_data_item|
            admin_data_item.admin_data_values.where(school:, academic_year:).count
          end.flatten.sum
        memo[[school, academic_year]] = total_collected_admin_data_items.positive?
      end
      @any_admin_data_collected[[school, academic_year]]
    end

    def sufficient_survey_responses?(school:, academic_year:)
      @sufficient_survey_responses ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] =
          sufficient_student_data?(school:, academic_year:) || sufficient_teacher_data?(school:, academic_year:)
      end
      @sufficient_survey_responses[[school, academic_year]]
    end

    def scorify(average:, school:, academic_year:)
      meets_student_threshold = sufficient_student_data?(school:, academic_year:)
      meets_teacher_threshold = sufficient_teacher_data?(school:, academic_year:)
      meets_admin_data_threshold = any_admin_data_collected?(school:, academic_year:)
      Score.new(average:, meets_teacher_threshold:, meets_student_threshold:, meets_admin_data_threshold:)
    end

    def collect_survey_item_average(survey_items:, school:, academic_year:)
      @collect_survey_item_average ||= Hash.new do |memo, (survey_items, school, academic_year)|
        averages = survey_items.map do |survey_item|
          SurveyItemResponse.grouped_responses(school:, academic_year:)[survey_item.id]
        end.remove_blanks
        memo[[survey_items, school, academic_year]] = averages.average || 0
      end
      @collect_survey_item_average[[survey_items, school, academic_year]]
    end

    def sufficient_student_data?(school:, academic_year:)
      return false unless includes_student_survey_items?

      subcategory.response_rate(school:, academic_year:).meets_student_threshold?
    end

    def sufficient_teacher_data?(school:, academic_year:)
      return false unless includes_teacher_survey_items?

      subcategory.response_rate(school:, academic_year:).meets_teacher_threshold?
    end

    def incalculable_score(school:, academic_year:)
      @incalculable_score ||= Hash.new do |memo, (school, academic_year)|
        lacks_sufficient_survey_data = !sufficient_student_data?(school:, academic_year:) &&
                                       !sufficient_teacher_data?(school:, academic_year:)
        memo[[school, academic_year]] = lacks_sufficient_survey_data && !includes_admin_data_items?
      end

      @incalculable_score[[school, academic_year]]
    end

    def collect_averages_for_teacher_student_and_admin_data(school:, academic_year:)
      scores = []
      scores << teacher_average(school:, academic_year:) if sufficient_teacher_data?(school:, academic_year:)
      scores << student_average(school:, academic_year:) if sufficient_student_data?(school:, academic_year:)
      scores << admin_data_averages(school:, academic_year:) if includes_admin_data_items?
      scores
    end

    def teacher_average(school:, academic_year:)
      @teacher_average ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] =
          collect_survey_item_average(survey_items: teacher_survey_items, school:, academic_year:)
      end

      @teacher_average[[school, academic_year]]
    end

    def student_average(school:, academic_year:)
      @student_average ||= Hash.new do |memo, (school, academic_year)|
        survey_items = student_survey_items_with_sufficient_responses(school:, academic_year:)
        memo[[school, academic_year]] = collect_survey_item_average(survey_items:, school:, academic_year:)
      end
      @student_average[[school, academic_year]]
    end

    def admin_data_averages(school:, academic_year:)
      @admin_data_averages ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] =
          AdminDataValue.where(school:, academic_year:, admin_data_item: admin_data_items).pluck(:likert_score)
      end
      @admin_data_averages[[school, academic_year]]
    end
  end
end
