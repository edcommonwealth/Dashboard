require "rails_helper"
require "nokogiri"

module Dashboard
  include Engine.routes.url_helpers
  RSpec.describe "/dashboard/examples/index", type: :view do
    before(:each) do
      assign(:examples, [
               Example.create!(
                 text: "Word",
                 body: "Sentence"
               ),
               Example.create!(
                 text: "Word",
                 body: "Sentence"
               )
             ])
    end

    it "renders a list of examples" do
      render
      cell_selector = Rails::VERSION::STRING >= "7" ? "div>p" : "tr>td"
      assert_select cell_selector, text: Regexp.new("Word".to_s), count: 2
      assert_select cell_selector, text: Regexp.new("Sentence".to_s), count: 2
    end
  end
end
