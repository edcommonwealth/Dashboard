module Dashboard
  class SurveyItemResponse < ApplicationRecord
    TEACHER_RESPONSE_THRESHOLD = 2
    STUDENT_RESPONSE_THRESHOLD = 10

    belongs_to :school, class_name: "School", foreign_key: :dashboard_school_id
    belongs_to :survey_item, class_name: "SurveyItem", foreign_key: :dashboard_survey_item_id
    belongs_to :academic_year, class_name: "AcademicYear", foreign_key: :dashboard_academic_year_id
    belongs_to :student, optional: true, class_name: "Student", foreign_key: :dashboard_student_id
    belongs_to :gender, optional: true, class_name: "Gender", foreign_key: :dashboard_gender_id
    belongs_to :income, optional: true, class_name: "Income", foreign_key: :dashboard_income_id
    belongs_to :ell, optional: true, class_name: "Ell", foreign_key: :dashboard_ell_id
    belongs_to :sped, optional: true, class_name: "Sped", foreign_key: :dashboard_sped_id

    has_one :measure, through: :survey_item

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
      SurveyItemResponse.joins("JOIN dashboard_student_races on dashboard_survey_item_responses.dashboard_student_id = dashboard_student_races.dashboard_student_id JOIN dashboard_students on dashboard_students.id = dashboard_student_races.dashboard_student_id").where(
        school:, academic_year:, grade: school.grades(academic_year:)
      ).where("dashboard_student_races.dashboard_race_id": race.id).group(:dashboard_survey_item_id).having("count(*) >= 10").average(:likert_score)
    }

    def self.grouped_responses(school:, academic_year:)
      @grouped_responses ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] =
          SurveyItemResponse.where(school:, academic_year:).group(:dashboard_survey_item_id).average(:likert_score)
      end
      @grouped_responses[[school, academic_year]]
    end

    def self.teacher_survey_items_with_sufficient_responses(school:, academic_year:)
      @teacher_survey_items_with_sufficient_responses ||= Hash.new do |memo, (school, academic_year)|
        hash = SurveyItem.joins("inner join dashboard_survey_item_responses on  dashboard_survey_item_responses.dashboard_survey_item_id = dashboard_survey_items.id")
                         .teacher_survey_items
                         .where("dashboard_survey_item_responses.dashboard_school_id": school.id, "dashboard_survey_item_responses.dashboard_academic_year_id": academic_year.id)
                         .group("dashboard_survey_items.id")
                         .having("count(*) > 0").count
        memo[[school, academic_year]] = hash
      end
      @teacher_survey_items_with_sufficient_responses[[school, academic_year]]
    end

    def self.student_survey_items_with_sufficient_responses_by_grade(school:, academic_year:)
      @student_survey_items_with_sufficient_responses_by_grade ||= Hash.new do |memo, (school, academic_year)|
        hash = SurveyItem.joins("inner join dashboard_survey_item_responses on  dashboard_survey_item_responses.dashboard_survey_item_id = dashboard_survey_items.id")
                         .student_survey_items
                         .where("dashboard_survey_item_responses.dashboard_school_id": school.id, "dashboard_survey_item_responses.dashboard_academic_year_id": academic_year.id)
                         .group(:grade, :id)
                         .count
        memo[[school, academic_year]] = hash
      end

      @student_survey_items_with_sufficient_responses_by_grade[[school, academic_year]]
    end
  end
end
