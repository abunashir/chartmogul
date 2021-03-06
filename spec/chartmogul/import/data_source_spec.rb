require "spec_helper"

describe Chartmogul::Import::DataSource do
  describe ".list" do
    it "lists existing data sources" do
      stub_data_source_list_api
      data_sources = Chartmogul::Import::DataSource.list

      expect(data_sources.data_sources.count).to eq(2)
      expect(data_sources.data_sources.first.name).to eq("In-house billing")
      expect(data_sources.data_sources.last.name).to eq("Enterprise billing")
    end
  end

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

  describe ".delete" do
    context "when valid data source uuid provided" do
      it "delete that data source" do
        data_source_uuid = "ds_ade45e52-47a4-231a-1ed2-eb6b9e541213"
        stub_data_source_delete_api(uuid: data_source_uuid)

        expect do
          Chartmogul::Import::DataSource.delete(uuid: data_source_uuid)
        end.not_to raise_error
      end
    end
  end
end
