# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module RaceColumn
          class Asian < GroupedBarColumnPresenter
            include Analyze::Graph::Column::ScoreForRace
            include Analyze::Graph::Column::RaceColumn::RaceCount
            def label
              %w[Asian]
            end

            def show_irrelevancy_message?
              false
            end

            def show_insufficient_data_message?
              false
            end

            def race
              Race.find_by_qualtrics_code 2
            end
          end
        end
      end
    end
  end
end
