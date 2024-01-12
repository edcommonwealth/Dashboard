module Dashboard
  class Seeder
    def seed_academic_years(*academic_year_ranges)
      academic_years = []
      academic_year_ranges.each do |range|
        academic_years << { range: }
      end

      AcademicYear.upsert_all(academic_years)
    end

    def seed_districts_and_schools(csv_file)
      dese_ids = []
      schools = []
      CSV.parse(File.read(csv_file), headers: true) do |row|
        district_name = row["District"].strip

        district_code = row["District Code"].try(:strip)
        dese_id = row["DESE School ID"].strip
        dese_ids << dese_id
        school_name = row["School Name"].strip
        school_code = row["School Code"].try(:strip)
        hs = row["HS?"]

        district = District.find_or_create_by! name: district_name
        district.slug = district_name.parameterize
        district.qualtrics_code = district_code
        district.save
        schools << { dese_id:, dashboard_district_id: district.id, qualtrics_code: school_code, name: school_name,
                     is_hs: marked?(hs), slug: school_name.parameterize }
      end

      School.insert_all(schools)

      Respondent.joins(:school).where.not("school.dese_id": dese_ids).destroy_all
      School.where.not(dese_id: dese_ids).destroy_all
      School.where(dese_id: nil).destroy_all
    end

    def seed_sqm_framework(csv_file)
      admin_data_item_ids = []
      CSV.parse(File.read(csv_file), headers: true) do |row|
        category_id = row["Category ID"].strip
        category_name = row["Category"].strip
        category = Category.find_or_create_by!(category_id:)
        category.update! name: category_name, description: row["Category Description"].strip,
                         short_description: row["Category Short Description"], category_id:, slug: category_name.parameterize

        subcategory_id = row["Subcategory ID"].strip
        subcategory = Subcategory.find_or_create_by!(subcategory_id:, category:)
        subcategory.update! name: row["Subcategory"].strip, description: row["Subcategory Description"].strip

        measure_id = row["Measure ID"].strip
        measure_name = row["Measures"].try(:strip)
        watch_low = row["Item Watch Low"].try(:strip)
        growth_low = row["Item Growth Low"].try(:strip)
        approval_low = row["Item Approval Low"].try(:strip)
        ideal_low = row["Item Ideal Low"].try(:strip)
        on_short_form = row["On Short Form?"].try(:strip)
        measure_description = row["Measure Description"].try(:strip)

        next if row["Source"] == "No source"

        measure = Measure.find_or_create_by!(measure_id:, subcategory:)
        measure.name = measure_name
        measure.description = measure_description
        measure.save!

        data_item_id = row["Survey Item ID"].strip
        scale_id = data_item_id.split("-")[0..1].join("-")
        scale = Scale.find_or_create_by!(scale_id:, measure:)

        if %w[Teachers Students].include? row["Source"]
          survey_item = SurveyItem.where(survey_item_id: data_item_id, scale:).first_or_create
          survey_item.watch_low_benchmark = watch_low if watch_low
          survey_item.growth_low_benchmark = growth_low if growth_low
          survey_item.approval_low_benchmark = approval_low if approval_low
          survey_item.ideal_low_benchmark = ideal_low if ideal_low
          survey_item.on_short_form = marked? on_short_form
          survey_item.update! prompt: row["Question/item (22-23)"].strip
        end

        if row["Source"] == "Admin Data" && row["Active admin & survey items"] == "TRUE"
          admin_data_item = AdminDataItem.where(admin_data_item_id: data_item_id, scale:).first_or_create
          admin_data_item.watch_low_benchmark = watch_low if watch_low
          admin_data_item.growth_low_benchmark = growth_low if growth_low
          admin_data_item.approval_low_benchmark = approval_low if approval_low
          admin_data_item.ideal_low_benchmark = ideal_low if ideal_low
          admin_data_item.description = row["Question/item (22-23)"].strip
          admin_data_item.hs_only_item = marked? row["HS only admin item?"]
          admin_data_item.save!
          admin_data_item_ids << admin_data_item.id
        end
      end

      AdminDataValue.where.not(admin_data_item: admin_data_item_ids).delete_all
      AdminDataItem.where.not(id: admin_data_item_ids).delete_all
    end

    #     def seed_demographics(csv_file)
    #       DemographicLoader.load_data(filepath: csv_file)
    #     end

    #     def seed_enrollment(csv_file)
    #       EnrollmentLoader.load_data(filepath: csv_file)
    #       missing_enrollment_for_current_year = Respondent.where(academic_year: AcademicYear.order(:range).last).none? do |respondent|
    #         respondent&.total_students&.zero?
    #       end

    #       EnrollmentLoader.clone_previous_year_data if missing_enrollment_for_current_year
    #     end

    #     def seed_staffing(csv_file)
    #       StaffingLoader.load_data(filepath: csv_file)
    #       missing_staffing_for_current_year = Respondent.where(academic_year: AcademicYear.order(:range).last).none? do |respondent|
    #         respondent&.total_teachers&.zero?
    #       end

    #       StaffingLoader.clone_previous_year_data if missing_staffing_for_current_year
    #     end

    private

    def marked?(mark)
      mark.present? ? mark.upcase.strip == "X" : false
    end

    def remove_commas(target)
      target.delete(",") if target.present?
    end
  end
end
