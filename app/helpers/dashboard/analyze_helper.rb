# frozen_string_literal: true

module Dashboard
  module AnalyzeHelper
    def svg_height
      400
    end

    def zone_label_width
      15
    end

    def graph_width
      85
    end

    def analyze_graph_height
      85
    end

    def analyze_zone_height
      analyze_graph_height / 5
    end

    def zone_height_percentage
      analyze_zone_height / 100.0
    end

    def analyze_category_link(district:, school:, academic_year:, category:)
      year = academic_year.range
      district_school_analyze_index_path(district, school,
                                         { year:, academic_years: year, category: category.category_id })
    end

    def analyze_subcategory_link(district:, school:, academic_year:, category:, subcategory:)
      year = academic_year.range
      district_school_analyze_index_path(district, school,
                                         { year: academic_year.range, category: category.category_id, subcategory: subcategory.subcategory_id })
    end

    def colors
      @colors ||= ["#49416D", "#FFC857", "#920020", "#00B0B3", "#B2D236", "#004D61", "#FFB3CC", "#FF3D00", "#212121", "#9E9D24",
                   "#689F38", "#388E3C", "#00897B", "#00796B", "#00695C", "#004D40", "#1B5E20", "#FF6F00", "#33691E", "#D50000",
                   "#827717", "#F57F17", "#FF6F00", "#E65100", "#BF360C", "#3E2723", "#263238", "#37474F", "#455A64"]
    end

    def empty_dataset?(measures:, school:, academic_year:)
      @empty_dataset ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] = measures.none? do |measure|
          response_rate = measure.subcategory.response_rate(school:, academic_year:)
          response_rate.meets_student_threshold? || response_rate.meets_teacher_threshold? || measure.sufficient_admin_data?(school:, academic_year:)
        end
      end

      @empty_dataset[[school, academic_year]]
    end

    def empty_survey_dataset?(measures:, school:, academic_year:)
      @empty_survey_dataset ||= Hash.new do |memo, (school, academic_year)|
        memo[[school, academic_year]] = measures.none? do |measure|
          response_rate = measure.subcategory.response_rate(school:, academic_year:)
          response_rate.meets_student_threshold? || response_rate.meets_teacher_threshold?
        end
      end
      @empty_survey_dataset[[school, academic_year]]
    end

    def base_url
      analyze_subcategory_link(district: @district, school: @school, academic_year: @academic_year, category: @presenter.category,
                               subcategory: @presenter.subcategory)
    end
  end
end
