require "csv"

module Dashboard
  module Dese
    class Loader
      def self.load_data(filepath:)
        admin_data_values = []
        ::CSV.parse(::File.read(filepath), headers: true) do |row|
          score = likert_score(row:)
          next unless valid_likert_score(likert_score: score)

          admin_data_values << create_admin_data_value(row:, score:)
        end

        AdminDataValue.upsert_all(admin_data_values.flatten.compact,
                                  unique_by: %i[dashboard_school_id dashboard_admin_data_item_id
                                                dashboard_academic_year_id])
      end

      private

      def self.valid_likert_score(likert_score:)
        likert_score >= 1 && likert_score <= 5
      end

      def self.likert_score(row:)
        likert_score = (row["Likert Score"] || row["LikertScore"] || row["Likert_Score"]).to_f
        likert_score.round_up_to_one.round_down_to_five
      end

      def self.ay(row:)
        row["Academic Year"] || row["AcademicYear"]
      end

      def self.dese_id(row:)
        row["DESE ID"] || row["Dese ID"] || row["Dese Id"] || row["School ID"]
      end

      def self.admin_data_item(row:)
        row["Admin Data Item"] || row["Item ID"] || row["Item Id"] || row["Item  ID"]
      end

      def self.create_admin_data_value(row:, score:)
        school = School.find_by_dese_id(dese_id(row:).to_i)
        admin_data_item_id = admin_data_item(row:)

        return if school.nil?
        return if admin_data_item_id.nil? || admin_data_item_id.blank?

        {
          likert_score: score,
          dashboard_school_id: school.id,
          dashboard_admin_data_item_id: AdminDataItem.find_by_admin_data_item_id(admin_data_item(row:)).id,
          dashboard_academic_year_id: AcademicYear.find_by_range(ay(row:)).id
        }
      end

      private_class_method :valid_likert_score
      private_class_method :likert_score
      private_class_method :ay
      private_class_method :dese_id
      private_class_method :admin_data_item
      private_class_method :create_admin_data_value
    end
  end
end
