# frozen_string_literal: true

require "csv"

module Dashboard
  class EnrollmentLoader
    def load_data(filepath:)
      schools = []
      enrollments = []
      CSV.parse(File.read(filepath), headers: true) do |row|
        row = EnrollmentRowValues.new(row:, schools: school_hash, academic_years: academic_year_hash)

        next unless row.school.present? && row.academic_year.present?

        schools << row.school

        enrollments << create_enrollment_entry(row:)
      end

      Respondent.upsert_all(enrollments, unique_by: %i[dashboard_school_id dashboard_academic_year_id])
    end

    def clone_previous_year_data
      years = AcademicYear.order(:range).last(2)
      previous_year = years.first
      current_year = years.last
      respondents = []
      School.all.each do |school|
        Respondent.where(school:, academic_year: previous_year).each do |respondent|
          respondents << { dashboard_school_id: respondent.school.id,
                           dashboard_academic_year_id: current_year.id,
                           pk: respondent.pk,
                           k: respondent.k,
                           one: respondent.one,
                           two: respondent.two,
                           three: respondent.three,
                           four: respondent.four,
                           five: respondent.five,
                           six: respondent.six,
                           seven: respondent.seven,
                           eight: respondent.eight,
                           nine: respondent.nine,
                           ten: respondent.ten,
                           eleven: respondent.eleven,
                           twelve: respondent.twelve,
                           total_students: respondent.total_students }
        end
      end
      Respondent.upsert_all(respondents, unique_by: %i[dashboard_school_id dashboard_academic_year_id])
    end

    private

    def school_hash
      @school_hash ||= School.by_dese_id
    end

    def academic_year_hash
      @academic_year_hash ||= AcademicYear.by_range
    end

    def create_enrollment_entry(row:)
      { dashboard_school_id: row.school.id,
        dashboard_academic_year_id: row.academic_year.id,
        pk: row.pk,
        k: row.k,
        one: row.one,
        two: row.two,
        three: row.three,
        four: row.four,
        five: row.five,
        six: row.six,
        seven: row.seven,
        eight: row.eight,
        nine: row.nine,
        ten: row.ten,
        eleven: row.eleven,
        twelve: row.twelve,
        total_students: row.total_students }
    end
  end

  class EnrollmentRowValues
    attr_reader :row, :schools, :academic_years

    def initialize(row:, schools:, academic_years:)
      @row = row
      @schools = schools
      @academic_years = academic_years
    end

    def school
      @school ||= begin
        dese_id = row["DESE ID"].try(:strip).to_i
        schools[dese_id]
      end
    end

    def academic_year
      @academic_year ||= begin
        year = row["Academic Year"]
        academic_years[year]
      end
    end

    def pk
      output = row["PK"] || row["pk"]
      output&.strip&.to_i
    end

    def k
      output = row["K"] || row["k"]
      output&.strip&.to_i
    end

    def one
      row["1"]&.strip&.to_i
    end

    def two
      row["2"]&.strip&.to_i
    end

    def three
      row["3"]&.strip&.to_i
    end

    def four
      row["4"]&.strip&.to_i
    end

    def five
      row["5"]&.strip&.to_i
    end

    def six
      row["6"]&.strip&.to_i
    end

    def seven
      row["7"]&.strip&.to_i
    end

    def eight
      row["8"]&.strip&.to_i
    end

    def nine
      row["9"]&.strip&.to_i
    end

    def ten
      row["10"]&.strip&.to_i
    end

    def eleven
      row["11"]&.strip&.to_i
    end

    def twelve
      row["12"]&.strip&.to_i
    end

    def total_students
      row["Total"].delete(",").to_i
    end
  end
end
