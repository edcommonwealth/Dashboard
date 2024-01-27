# frozen_string_literal: true

module Dashboard
  module Analyze
    module Slice
      class AllData
        def to_s
          "All Data"
        end

        def slug
          "all-data"
        end

        def graphs
          [Analyze::Graph::AllData.new]
        end
      end
    end
  end
end
