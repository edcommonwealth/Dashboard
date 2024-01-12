namespace :dashboard do
  namespace :db do
    desc "seed db"
    task seed: :environment do
      seeder = Dashboard::Seeder.new

      seeder.seed_academic_years "2016-17", "2017-18", "2018-19", "2019-20", "2020-21", "2021-22", "2022-23",
                                 "2023-24"
      seeder.seed_districts_and_schools Dashboard::Engine.root.join("data", "dashboard",
                                                                    "master_list_of_schools_and_districts.csv")
      seeder.seed_sqm_framework Dashboard::Engine.root.join("data", "dashboard", "sqm_framework.csv")
      # seeder.seed_demographics Rails.root.join("data", "demographics.csv")
      # seeder.seed_enrollment Rails.root.join("data", "enrollment", "enrollment.csv")
      # seeder.seed_enrollment Rails.root.join("data", "enrollment", "nj_enrollment.csv")
      # seeder.seed_enrollment Rails.root.join("data", "enrollment", "wi_enrollment.csv")
      # seeder.seed_staffing Rails.root.join("data", "staffing", "staffing.csv")
      # seeder.seed_staffing Rails.root.join("data", "staffing", "nj_staffing.csv")
      # seeder.seed_staffing Rails.root.join("data", "staffing", "wi_staffing.csv")
    end
  end
end
