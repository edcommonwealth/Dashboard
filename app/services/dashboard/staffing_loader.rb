# frozen_string_literal: true

require "csv"

module Dashboard
  class StaffingLoader
    def self.load_data(filepath:)
      schools = []
      respondents = []
      ::CSV.parse(::File.read(filepath), headers: true) do |row|
        row = StaffingRowValues.new(row:)
        next unless row.school.present? && row.academic_year.present?

        schools << row.school

        respondents << { dashboard_school_id: row.school.id, dashboard_academic_year_id: row.academic_year.id,
                         total_teachers: row.fte_count }
      end

      Respondent.upsert_all(respondents, unique_by: %i[dashboard_school_id dashboard_academic_year_id])
    end

    def self.clone_previous_year_data
      years = AcademicYear.order(:range).last(2)
      previous_year = years.first
      current_year = years.last
      respondents = []
      School.all.each do |school|
        Respondent.where(school:, academic_year: previous_year).each do |respondent|
          respondents << { dashboard_school_id: respondent.school.id, dashboard_academic_year_id: current_year.id,
                           total_teachers: respondent.total_teachers }
        end
      end
      Respondent.upsert_all(respondents, unique_by: %i[dashboard_school_id dashboard_academic_year_id])
    end
  end

  class StaffingRowValues
    attr_reader :row

    def initialize(row:)
      @row = row
    end

    def school
      @school ||= begin
        dese_id = row["DESE ID"].strip.to_i
        School.find_by_dese_id(dese_id)
      end
    end

    def academic_year
      @academic_year ||= begin
        year = row["Academic Year"]
        AcademicYear.find_by_range(year)
      end
    end

    def fte_count
      row["FTE Count"]
    end
  end
end
