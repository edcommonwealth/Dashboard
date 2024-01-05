module Dashboard
  class AdminDataItem < ApplicationRecord
    belongs_to :dashboard_scale
    has_many :dashboard_admin_data_values

    scope :for_measures, lambda { |measures|
      joins(:scale).where('scale.measure': measures)
    }

    scope :non_hs_items_for_measures, lambda { |measure|
      for_measures(measure).where(hs_only_item: false)
    }
  end
end
