# frozen_string_literal: true

module Dashboard
  module Analyze
    module Slice
      class StudentsAndTeachers
        def to_s
          "Students & Teachers"
        end

        def slug
          "students-and-teachers"
        end

        def graphs
          [Analyze::Graph::StudentsAndTeachers.new]
        end
      end
    end
  end
end
