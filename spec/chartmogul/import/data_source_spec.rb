require "spec_helper"

describe Chartmogul::Import::DataSource do
  describe ".create" do
    context "when valid data provided" do
      it "creates a new data srouce" do
        data_source_param = { name: "In-house billing" }
        stub_data_source_create_api(data_source_param)
        data_source = Chartmogul::Import::DataSource.create(data_source_param)

        expect(data_source.uuid).not_to be_nil
        expect(data_source.name).to eq("In-house billing")
      end
    end
  end
end
