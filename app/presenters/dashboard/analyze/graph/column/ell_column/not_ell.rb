# frozen_string_literal: true

module Analyze
  module Graph
    module Column
      module EllColumn
        class NotEll < GroupedBarColumnPresenter
          include Analyze::Graph::Column::EllColumn::ScoreForEll
          include Analyze::Graph::Column::EllColumn::EllCount
          def label
            ["Not ELL"]
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
            ::Ell.find_by_slug "not-ell"
          end
        end
      end
    end
  end
end
