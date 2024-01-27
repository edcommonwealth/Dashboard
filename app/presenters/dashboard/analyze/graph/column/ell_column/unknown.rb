# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module EllColumn
          class Unknown < GroupedBarColumnPresenter
            include Analyze::Graph::Column::EllColumn::ScoreForEll
            include Analyze::Graph::Column::EllColumn::EllCount
            def label
              %w[Unknown]
            end

            def basis
              "student"
            end

            def show_irrelevancy_message?
              false
            end

            def show_insufficient_data_message?
              false
            end

            def ell
              Ell.find_by_slug "unknown"
            end
          end
        end
      end
    end
  end
end
