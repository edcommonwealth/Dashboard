# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module SpedColumn
          class NotSped < GroupedBarColumnPresenter
            include Analyze::Graph::Column::SpedColumn::ScoreForSped
            include Analyze::Graph::Column::SpedColumn::SpedCount

            def label
              ["Not Special", "Education"]
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

            def sped
              Dashboard::Sped.find_by_slug "not-special-education"
            end
          end
        end
      end
    end
  end
end
