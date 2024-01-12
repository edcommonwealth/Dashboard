module Dashboard
  class AdminDataValue < ApplicationRecord
    belongs_to :school, class_name: "School", foreign_key: :dashboard_school_id
    belongs_to :admin_data_item, class_name: "AdminDataItem", foreign_key: :dashboard_admin_data_item_id
    belongs_to :academic_year, class_name: "AcademicYear", foreign_key: :dashboard_academic_year_id

    validates :likert_score, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
  end
end
