# frozen_string_literal: true

module Dashboard
  class SqmApplicationController < ApplicationController
    protect_from_forgery with: :exception, prepend: true
    before_action :set_schools_and_districts
    before_action :authenticate_district

    helper HeaderHelper

    private

    def authenticate_district
      authenticate(district_name, "#{district_name}!")
    end

    def district_name
      @district_name ||= @district.name.split(" ").first.downcase
    end

    def set_schools_and_districts
      @district = District.find_by_slug district_slug
      @districts = District.all.order(:name)
      @school = School.find_by_slug(school_slug)
      @schools = School.includes([:district]).where(district: @district).order(:name)
      @academic_year = AcademicYear.find_by_range params[:year]
      @academic_years = AcademicYear.all.order(range: :desc)
    end

    def district_slug
      params[:district_id]
    end

    def school_slug
      params[:school_id]
    end

    def authenticate(username, password)
      authenticate_or_request_with_http_basic do |u, p|
        u == username && p == password
      end
    end
  end
end
