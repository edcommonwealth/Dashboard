# frozen_string_literal: true

module Dashboard
  module Analyze
    module Graph
      module Column
        module Grade
          class Seven < GroupedBarColumnPresenter
            include Analyze::Graph::Column::Grade::ScoreForGrade
            include Analyze::Graph::Column::Grade::GradeCount
            def label
              %w[Grade 7]
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

            def grade
              7
            end
          end
        end
      end
    end
  end
end
