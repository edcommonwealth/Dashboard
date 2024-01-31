module Dashboard
  class Student < ApplicationRecord
    has_many :student_races, class_name: "StudentRace", foreign_key: :dashboard_student_id
    has_many :races, through: :student_races, foreign_key: :dashboard_race_id

    encrypts :lasid, deterministic: true
  end
end
