module Dashboard
  class Student < ApplicationRecord
    # has_many :dashboard_survey_item_responses
    has_many :dashboard_student_races
    has_and_belongs_to_many :races, join_table: :student_races

    encrypts :lasid, deterministic: true
  end
end
