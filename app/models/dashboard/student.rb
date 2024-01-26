module Dashboard
  class Student < ApplicationRecord
    # has_many :dashboard_survey_item_responses
    has_and_belongs_to_many :races, join_table: :dashboard_student_races, class_name: "Race",
                                    foreign_key: :dashboard_race_id, association_foreign_key: :dashboard_race_id

    encrypts :lasid, deterministic: true
  end
end
