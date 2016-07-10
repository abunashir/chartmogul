require "spec_helper"

describe Chartmogul::Import::Transaction do
  describe ".create" do
    it "creates a new transaction for a invoice" do
      transaction_attributes = {
        type: "refund",
        invoice_uuid: "invoice_001",
        result: "successful",
        date: "2015-12-25 18:10:00",
        external_id: "transaction_001"
      }

      stub_transaction_create_api(transaction_attributes)
      transaction = Chartmogul::Import::Transaction.create(
        transaction_attributes
      )

      expect(transaction.uuid).not_to be_nil
      expect(transaction.type).to eq(transaction_attributes[:type])
      expect(transaction.result).to eq(transaction_attributes[:result])
    end
  end
end
