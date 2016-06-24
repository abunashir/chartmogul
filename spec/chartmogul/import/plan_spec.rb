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
end
