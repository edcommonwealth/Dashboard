module Dashboard
  class District < ApplicationRecord
    has_many :schools, class_name: "Dashboard::School"
    has_many :dashboard_schools, class_name: "Dashboard::School"

    validates :name, presence: true

    scope :alphabetic, -> { order(name: :asc) }

    include FriendlyId

    friendly_id :name, use: [:slugged]

    def short_name
      name.split(" ").first.downcase
    end
  end
end
