require "rails_helper"

module Dashboard
  RSpec.xdescribe "dashboard/examples/edit", type: :view do
    let(:example) do
      Example.create!(
        text: "MyString",
        body: "MyText"
      )
    end

    before(:each) do
      assign(:example, example)
    end

    it "renders the edit example form" do
      render

      assert_select "form[action=?][method=?]", example_path(example), "post" do
        assert_select "input[name=?]", "example[text]"

        assert_select "textarea[name=?]", "example[body]"
      end
    end
  end
end
