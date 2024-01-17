# frozen_string_literal: true

module Dashboard
  class SurveyResponsesDataLoader
    def load_data(filepath:)
      File.open(filepath) do |file|
        headers = file.first
        headers_array = CSV.parse(headers).first
        all_survey_items = survey_items(headers:)

        file.lazy.each_slice(500) do |lines|
          survey_item_responses = CSV.parse(lines.join, headers:).map do |row|
            process_row(row: SurveyItemValues.new(row:, headers: headers_array, survey_items: all_survey_items,
                                                  schools:))
          end
          SurveyItemResponse.import survey_item_responses.compact.flatten, batch_size: 500,
                                                                           on_duplicate_key_update: :all
        end
      end
    end

    def from_file(file:)
      headers = file.gets
      headers_array = CSV.parse(headers).first
      all_survey_items = survey_items(headers:)

      survey_item_responses = []
      row_count = 0
      until file.eof?
        line = file.gets
        next unless line.present?

        CSV.parse(line, headers:).map do |row|
          survey_item_responses << process_row(row: SurveyItemValues.new(row:, headers: headers_array,
                                                                         survey_items: all_survey_items, schools:))
        end

        row_count += 1
        next unless row_count == 500

        SurveyItemResponse.import survey_item_responses.compact.flatten, batch_size: 500, on_duplicate_key_update: :all
        survey_item_responses = []
        row_count = 0
      end

      SurveyItemResponse.import survey_item_responses.compact.flatten, batch_size: 500, on_duplicate_key_update: :all
    end

    private

    def schools
      @schools = School.by_dese_id
    end

    def genders
      @genders = Gender.by_qualtrics_code
    end

    def races
      @races = Race.by_qualtrics_code
    end

    def incomes
      @incomes ||= Income.by_slug
    end

    def ells
      @ells ||= Ell.by_designation
    end

    def speds
      @speds ||= Sped.by_designation
    end

    def process_row(row:)
      return unless row.dese_id?
      return unless row.school.present?

      process_survey_items(row:)
    end

    def process_survey_items(row:)
      student = Student.find_or_create_by(response_id: row.response_id, lasid: row.lasid)
      student.races.delete_all
      tmp_races = row.races.map { |race| races[race] }
      student.races += tmp_races

      row.survey_items.map do |survey_item|
        likert_score = row.likert_score(survey_item_id: survey_item.survey_item_id) || next

        unless likert_score.valid_likert_score?
          puts "Response ID: #{row.response_id}, Likert score: #{likert_score} rejected" unless likert_score == "NA"
          next
        end
        response = row.survey_item_response(survey_item:)
        create_or_update_response(survey_item_response: response, likert_score:, row:, survey_item:, student:)
      end.compact
    end

    def create_or_update_response(survey_item_response:, likert_score:, row:, survey_item:, student:)
      gender = genders[row.gender]
      grade = row.grade
      income = incomes[row.income.parameterize]
      ell = ells[row.ell]
      sped = speds[row.sped]

      if survey_item_response.present?
        survey_item_response.likert_score = likert_score
        survey_item_response.grade = grade
        survey_item_response.gender = gender
        survey_item_response.recorded_date = row.recorded_date
        survey_item_response.income = income
        survey_item_response.ell = ell
        survey_item_response.sped = sped
        survey_item_response.student = student
        survey_item_response
      else
        SurveyItemResponse.new(response_id: row.response_id, academic_year: row.academic_year, school: row.school, survey_item:,
                               likert_score:, grade:, gender:, recorded_date: row.recorded_date, income:, ell:, sped:, student:)
      end
    end

    def survey_items(headers:)
      SurveyItem.where(survey_item_id: get_survey_item_ids_from_headers(headers:))
    end

    def get_survey_item_ids_from_headers(headers:)
      CSV.parse(headers).first
         .filter(&:present?)
         .filter { |header| header.start_with? "t-", "s-" }
    end
  end

  module StringMonkeyPatches
    def valid_likert_score?
      to_i.between? 1, 5
    end
  end

  String.include StringMonkeyPatches
end