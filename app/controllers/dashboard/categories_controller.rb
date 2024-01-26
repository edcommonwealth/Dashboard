# frozen_string_literal: true

module Dashboard
  class CategoriesController < SqmApplicationController
    helper GaugeHelper

    def show
      @categories = Category.sorted.map { |category| CategoryPresenter.new(category:) }

      puts params
      @category = CategoryPresenter.new(category: Category.find_by_slug(params[:id]))
    end
  end
end
