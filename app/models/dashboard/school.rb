module Dashboard
  class School < ApplicationRecord
    include FriendlyId
    friendly_id :name, use: :slugged

    belongs_to :district, class_name: "District", foreign_key: :dashboard_district_id

    # has_many :dashboard_survey_item_responses, dependent: :delete_all

    validates :name, presence: true

    scope :alphabetic, -> { order(name: :asc) }
    scope :school_hash, -> { all.map { |school| [school.dese_id, school] }.to_h }

    def self.find_by_district_code_and_school_code(district_code, school_code)
      School
        .joins(:district)
        .where(districts: { qualtrics_code: district_code })
        .find_by_qualtrics_code(school_code)
    end

    def grades(academic_year:)
      @grades ||= Respondent.by_school_and_year(school: self,
                                                academic_year:)&.enrollment_by_grade&.keys || (-1..12).to_a
    end
  end
end
