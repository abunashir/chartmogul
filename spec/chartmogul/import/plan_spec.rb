require "spec_helper"

describe Chartmogul::Import::Plan do
  describe ".create" do
    it "creates a new plan" do
      plan_attributes = {
        data_source_uuid: "ds_uuid_001",
        name: "Bronze Plan",
        interval_count: 1,
        interval_unit: "month",
        external_id: "plan_001"
      }

      stub_plan_create_api(plan_attributes)
      plan = Chartmogul::Import::Plan.create(plan_attributes)

      expect(plan.uuid).not_to be_nil
      expect(plan.name).to eq(plan_attributes[:name])
      expect(plan.data_source_uuid).to eq(plan_attributes[:data_source_uuid])
    end
  end

  describe ".list" do
    it "lists all the plans" do
      listing_options = { page: 1, per_page: 3 }
      stub_plan_list_api(listing_options)
      plans = Chartmogul::Import::Plan.list(listing_options)

      expect(plans.current_page).to eq(1)
      expect(plans.plans.count).to eq(3)
      expect(plans.plans.first.uuid).not_to be_nil
    end
  end
end
