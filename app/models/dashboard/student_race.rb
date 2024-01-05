module Dashboard
  class StudentRace < ApplicationRecord
    belongs_to :dashboard_student
    belongs_to :dashboard_race
  end
end
