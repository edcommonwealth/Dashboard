require "rails_helper"

module Dashboard
  include Engine.routes.url_helpers
  RSpec.describe "dashboard/examples/new", type: :view do
    before(:each) do
      assign(:example, Example.new(
                         text: "MyString",
                         body: "MyText"
                       ))
    end

    it "renders new example form" do
      render

      assert_select "form[action=?][method=?]", examples_path, "post" do
        assert_select "input[name=?]", "example[text]"

        assert_select "textarea[name=?]", "example[body]"
      end
    end
  end
end
