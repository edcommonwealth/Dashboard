module Dashboard
  class AdminDataItem < ApplicationRecord
    belongs_to :scale, class_name: "Scale", foreign_key: :dashboard_scale_id
    has_many :admin_data_values, class_name: "AdminDataValue", foreign_key: :dashboard_admin_data_item_id

    scope :for_measures, lambda { |measures|
      joins(:scale).where('scale.measure': measures)
    }

    scope :non_hs_items_for_measures, lambda { |measure|
      for_measures(measure).where(hs_only_item: false)
    }
  end
end
