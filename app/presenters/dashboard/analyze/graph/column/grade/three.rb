# frozen_string_literal: true

module Analyze
  module Graph
    module Column
      module Grade
        class Three < GroupedBarColumnPresenter
          include Analyze::Graph::Column::Grade::ScoreForGrade
          include Analyze::Graph::Column::Grade::GradeCount
          def label
            %w[Grade 3]
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
            3
          end
        end
      end
    end
  end
end
