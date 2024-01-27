# frozen_string_literal: true

module Dashboard
  module Analyze
    module Source
      class SurveyData
        attr_reader :slices

        include Analyze::Slice

        def initialize(slices:)
          @slices = slices
        end

        def to_s
          "Survey Data Only"
        end

        def slug
          "survey-data-only"
        end
      end
    end
  end
end
