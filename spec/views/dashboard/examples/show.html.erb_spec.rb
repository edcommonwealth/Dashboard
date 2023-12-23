require "rails_helper"

module Dashboard
  RSpec.describe "dashboard/examples/show", type: :view do
    before(:each) do
      assign(:example, Example.create!(
                         text: "Word",
                         body: "Sentence"
                       ))
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/Word/)
      expect(rendered).to match(/Sentence/)
    end
  end
end
