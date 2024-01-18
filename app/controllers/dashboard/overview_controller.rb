# frozen_string_literal: true

module Dashboard
  class OverviewController < SqmApplicationController
    before_action :check_empty_dataset, only: [:index]
    helper VarianceHelper

    def index
      @variance_chart_row_presenters = measures.map(&method(:presenter_for_measure))
      @category_presenters = categories.map { |category| CategoryPresenter.new(category:) }
      @student_response_rate_presenter = ResponseRatePresenter.new(focus: :student, school: @school,
                                                                   academic_year: @academic_year)
      @teacher_response_rate_presenter = ResponseRatePresenter.new(focus: :teacher, school: @school,
                                                                   academic_year: @academic_year)
    end

    private

    def presenter_for_measure(measure)
      score = measure.score(school: @school, academic_year: @academic_year)

      VarianceChartRowPresenter.new(measure:, score:)
    end

    def check_empty_dataset
      @has_empty_dataset = subcategories.none? do |subcategory|
        response_rate = subcategory.response_rate(school: @school, academic_year: @academic_year)
        response_rate.meets_student_threshold? || response_rate.meets_teacher_threshold?
      end
    end

    def measures
      @measures ||= subcategories.flat_map(&:measures)
    end

    def subcategories
      @subcategories ||= categories.flat_map(&:subcategories)
    end

    def categories
      @categories ||= Category.sorted.includes(%i[measures scales admin_data_items subcategories])
    end
  end
end