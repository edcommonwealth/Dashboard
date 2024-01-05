module Dashboard
  class ResponseRate < ApplicationRecord
    belongs_to :dashboard_subcategory
    belongs_to :school
    belongs_to :dashboard_academic_year
  end
end
