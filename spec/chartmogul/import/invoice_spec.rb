require "spec_helper"

describe Chartmogul::Import::Invoice do
  describe ".create" do
    it "creates a new invoice" do
      customer_uuid = "customer_001"
      invoice_attributes = {
        external_id: "invoice_001",
        currency: "USD",
        date: "2015-11-01 00:00:00",
        due_date: "2015-11-15 00:00:00",
        line_items: [line_item_attributes],
        transactions: [transaction_attributes]
      }

      stub_invoice_create_api(customer_uuid, invoices: [invoice_attributes])
      invoices = Chartmogul::Import::Invoice.create(
        uuid: customer_uuid, invoice: invoice_attributes
      )

      expect(invoices.invoices.first.uuid).not_to be_nil
      expect(invoices.invoices.first.line_items.count).to eq(1)
      expect(invoices.invoices.first.line_items.first.uuid).not_to be_nil
      expect(invoices.invoices.first.transactions.first.uuid).not_to be_nil
    end
  end

  def line_item_attributes
    {
      type: "one_time",
      description: "Setup Fees",
      amount_in_cents: 2500,
      quantity: 1,
      discount_code: "PSO86",
      discount_amount_in_cents: 500,
      tax_amount_in_cents: 450
    }
  end

  def transaction_attributes
    {
      date: "2015-11-05 00:14:23",
      type: "payment",
      result: "successful"
    }
  end
end
