require "rails_helper"

module Dashboard
  RSpec.describe ExamplesController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "dashboard/examples").to route_to("dashboard/examples#index")
      end

      it "routes to #new" do
        expect(get: "dashboard/examples/new").to route_to("dashboard/examples#new")
      end

      it "routes to #show" do
        expect(get: "dashboard/examples/1").to route_to("dashboard/examples#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/dashboard/examples/1/edit").to route_to("dashboard/examples#edit", id: "1")
      end

      it "routes to #create" do
        expect(post: "/dashboard/examples").to route_to("dashboard/examples#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/dashboard/examples/1").to route_to("dashboard/examples#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/dashboard/examples/1").to route_to("dashboard/examples#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/dashboard/examples/1").to route_to("dashboard/examples#destroy", id: "1")
      end
    end
  end
end
