require "rails_helper"

module Dashboard
  RSpec.describe Example, type: :model do
    it "creates an example to test rspec and factorybot" do
      create(:example)
      expect(Example.count).to eq 1
    end
  end
end
