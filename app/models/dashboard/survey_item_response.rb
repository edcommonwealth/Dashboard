module Dashboard
  class SurveyItemResponse < ApplicationRecord
    TEACHER_RESPONSE_THRESHOLD = 2
    STUDENT_RESPONSE_THRESHOLD = 10

    belongs_to :school
    belongs_to :dashboard_survey_item
    belongs_to :dashboard_academic_year
    belongs_to :dashboard_student, optional: true
    belongs_to :dashboard_gender, optional: true
    belongs_to :dashboard_income, optional: true
    belongs_to :dashboard_ell, optional: true
    belongs_to :dashboard_sped, optional: true

    has_one :dashboard_measure, through: :dashboard_survey_item

    validates :likert_score, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

    scope :exclude_boston, lambda {
                             includes(school: :district).where.not("district.name": "Boston")
                           }

    scope :averages_for_grade, lambda { |survey_items, school, academic_year, grade|
      SurveyItemResponse.where(survey_item: survey_items, school:,
                               academic_year:, grade:).group(:survey_item).having("count(*) >= 10").average(:likert_score)
    }

    scope :averages_for_gender, lambda { |survey_items, school, academic_year, gender|
      SurveyItemResponse.where(survey_item: survey_items, school:,
                               academic_year:, gender:, grade: school.grades(academic_year:)).group(:survey_item).having("count(*) >= 10").average(:likert_score)
    }

    scope :averages_for_income, lambda { |survey_items, school, academic_year, income|
      SurveyItemResponse.where(survey_item: survey_items, school:,
                               academic_year:, income:, grade: school.grades(academic_year:)).group(:survey_item).having("count(*) >= 10").average(:likert_score)
    }

    scope :averages_for_ell, lambda { |survey_items, school, academic_year, ell|
      SurveyItemResponse.where(survey_item: survey_items, school:,
                               academic_year:, ell:, grade: school.grades(academic_year:)).group(:survey_item).having("count(*) >= 10").average(:likert_score)
    }

    scope :averages_for_sped, lambda { |survey_items, school, academic_year, sped|
      SurveyItemResponse.where(survey_item: survey_items, school:,
                               academic_year:, sped:, grade: school.grades(academic_year:)).group(:survey_item).having("count(*) >= 10").average(:likert_score)
    }

    scope :averages_for_race, lambda { |school, academic_year, race|
      SurveyItemResponse.joins("JOIN student_races on survey_item_responses.student_id = student_races.student_id JOIN students on students.id = student_races.student_id").where(
        school:, academic_year:, grade: school.grades(academic_year:)
      ).where("student_races.race_id": race.id).group(:survey_item_id).having("count(*) >= 10").average(:likert_score)
    }

    def self.grouped_responses(school:, academic_year:)
      @grouped_responses ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] =
          SurveyItemResponse.where(school:, academic_year:).group(:survey_item_id).average(:likert_score)
      end
      @grouped_responses[[school, academic_year]]
    end

    def self.teacher_survey_items_with_sufficient_responses(school:, academic_year:)
      @teacher_survey_items_with_sufficient_responses ||= Hash.new do |memo, (school, academic_year)|
        hash = SurveyItem.joins("inner join survey_item_responses on  survey_item_responses.survey_item_id = survey_items.id")
                         .teacher_survey_items
                         .where("survey_item_responses.school": school, "survey_item_responses.academic_year": academic_year)
                         .group("survey_items.id")
                         .having("count(*) > 0").count
        memo[[school, academic_year]] = hash
      end
      @teacher_survey_items_with_sufficient_responses[[school, academic_year]]
    end

    def self.student_survey_items_with_sufficient_responses_by_grade(school:, academic_year:)
      @student_survey_items_with_sufficient_responses_by_grade ||= Hash.new do |memo, (school, academic_year)|
        hash = SurveyItem.joins("inner join survey_item_responses on  survey_item_responses.survey_item_id = survey_items.id")
                         .student_survey_items
                         .where("survey_item_responses.school": school, "survey_item_responses.academic_year": academic_year)
                         .group(:grade, :id)
                         .count
        memo[[school, academic_year]] = hash
      end

      @student_survey_items_with_sufficient_responses_by_grade[[school, academic_year]]
    end
  end
end
