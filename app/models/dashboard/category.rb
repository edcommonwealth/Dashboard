module Dashboard
  class Category < ApplicationRecord
    include FriendlyId
    friendly_id :name, use: [:slugged]

    scope :sorted, -> { order(:category_id) }

    has_many :subcategories
    has_many :measures, through: :subcategories
    has_many :admin_data_items, through: :measures
    has_many :scales, through: :subcategories
  end
end
