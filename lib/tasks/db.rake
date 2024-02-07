namespace :dashboard do
  namespace :db do
    desc "seed db"
    task seed: :environment do
      seeder = Dashboard::Seeder.new

      seeder.seed_academic_years "2016-17", "2017-18", "2018-19", "2019-20", "2020-21", "2021-22", "2022-23",
                                 "2023-24"
      seeder.seed_districts_and_schools Dashboard::Engine.root.join("data",
                                                                    "master_list_of_schools_and_districts.csv")
      seeder.seed_sqm_framework Dashboard::Engine.root.join("data", "sqm_framework.csv")
      seeder.seed_demographics Dashboard::Engine.root.join("data", "demographics.csv")

      Dir.glob("#{Dashboard::Engine.root}/data/dashboard/enrollment/*.csv").each do |file|
        seeder.seed_enrollment file
      end

      Dir.glob("#{Dashboard::Engine.root}/data/dashboard/staffing/*.csv").each do |file|
        seeder.seed_staffing file
      end
    end
  end
end
