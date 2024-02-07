namespace :dashboard do
  namespace :scrape do
    desc "scrape dese site for admin data"
    task admin: :environment do
      puts "scraping data from dese"
      scrapers = [Dashboard::Dese::OneAOne, Dashboard::Dese::OneAThree, Dashboard::Dese::TwoAOne, Dashboard::Dese::TwoCOne, Dashboard::Dese::ThreeAOne, Dashboard::Dese::ThreeATwo,
                  Dashboard::Dese::ThreeBOne, Dashboard::Dese::ThreeBTwo, Dashboard::Dese::FourAOne, Dashboard::Dese::FourBTwo, Dashboard::Dese::FourDOne, Dashboard::Dese::FiveCOne, Dashboard::Dese::FiveDTwo]
      scrapers.each do |scraper|
        scraper.new.run_all
      end
    end

    desc "scrape dese site for teacher staffing information"
    task enrollment: :environment do
      Dese::ThreeATwo.new.scrape_enrollments(filepath: Dashboard::Engine.root.join("data", "enrollment",
                                                                                   "enrollments.csv"))
    end

    desc "scrape dese site for student staffing information"
    task staffing: :environment do
      Dashboard::Dese::Staffing.new.run_all
    end
  end
end
