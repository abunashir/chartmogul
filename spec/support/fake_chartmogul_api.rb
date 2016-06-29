module FakeChartmogulApi
  def stub_data_source_create_api(data_source)
    stub_api_response(
      :post,
      "import/data_sources",
      data: data_source,
      filename: "datasource_created",
      status: 201
    )
  end

  def stub_data_source_list_api
    stub_api_response(
      :get, "import/data_sources", filename: "datasource_list", status: 200
    )
  end

  def stub_data_source_delete_api(uuid:)
    stub_api_response(
      :delete, "import/data_sources/#{uuid}", filename: "empty", status: 204
    )
  end

  def stub_customer_create_api(customer_attributes)
    stub_api_response(
      :post,
      "import/customers",
      data: customer_attributes,
      filename: "customer_created",
      status: 201
    )
  end

  def stub_customer_list_api(options)
    stub_api_response(
      :get,
      ["import/customers", resource_params(options)].join("?"),
      filename: "customer_list",
      status: 200
    )
  end

  def stub_customer_delete_api(uuid:)
    stub_api_response(
      :delete, "import/customers/#{uuid}", filename: "empty", status: 204
    )
  end

  def stub_plan_create_api(plan_attributes)
    stub_api_response(
      :post,
      plan_end_point,
      data: plan_attributes,
      filename: "plan_created",
      status: 201
    )
  end

  def stub_plan_list_api(options)
    stub_api_response(
      :get,
      [plan_end_point, resource_params(options)].join("?"),
      filename: "plan_list",
      status: 200
    )
  end

  def stub_invoice_create_api(customer_uuid, invoices:)
    stub_api_response(
      :post,
      invoice_end_point(customer_uuid),
      data: { invoices: invoices },
      filename: "invoices_created",
      status: 201
    )
  end

  def stub_invoice_listing_api(uuid:, **listing_options)
    stub_api_response(
      :get,
      [invoice_end_point(uuid), resource_params(listing_options)].join("?"),
      filename: "invoice_list",
      status: 200
    )
  end

  def stub_transaction_create_api(uuid:, **attributes)
    stub_api_response(
      :post,
      transaction_end_point(uuid),
      data: attributes,
      filename: "transaction_created",
      status: 201
    )
  end

  def stub_subscription_listing_api(uuid:, **options)
    stub_api_response(
      :get,
      [subscription_end_point(uuid), resource_params(options)].join("?"),
      filename: "subscription_list",
      status: 200
    )
  end

  def stub_subscription_cancellation_api(uuid:, cancelled_at:)
    stub_api_response(
      :patch,
      ["import", "subscriptions", uuid].join("/"),
      data: { cancelled_at: cancelled_at },
      filename: "subscription_cancelled",
      status: 200
    )
  end

  def stub_customer_find_api(customer_id)
    stub_api_response(
      :get,
      ["customers", customer_id].join("/"),
      filename: "customer",
      status: 200
    )
  end

  def stub_customer_search_api(options)
    stub_api_response(
      :get,
      [search_end_point, resource_params(options)].join("?"),
      filename: "customer_entries",
      status: 200
    )
  end

  def stub_enrichment_customer_list_api(options)
    stub_api_response(
      :get,
      ["customers", resource_params(options)].join("?"),
      filename: "customer_entries",
      status: 200
    )
  end

  def stub_customer_attribute_list_api(customer_id)
    stub_api_response(
      :get,
      ["customers", customer_id, "attributes"].join("/"),
      filename: "attribute_list",
      status: 200
    )
  end

  def stub_customer_tag_create_api(customer_id:, tag:)
    stub_api_response(
      :post,
      ["customers", customer_id, "attributes", "tags"].join("/"),
      data: { tags: [tag] },
      filename: "tag_created",
      status: 200
    )
  end

  def stub_tag_create_api_with_email(email:, tag:)
    stub_api_response(
      :post,
      "customers/attributes/tags",
      data: { tags: [tag], email: email },
      filename: "tag_created",
      status: 200
    )
  end

  def stub_customer_tag_delete_api(customer_id:, tag:)
    stub_api_response(
      :delete,
      ["customers", customer_id, "attributes", "tags"].join("/"),
      data: { tags: [tag] },
      filename: "tag_deleted",
      status: 200
    )
  end

  private

  def stub_api_response(method, end_point, filename:, status: 200, data: nil)
    stub_request(method, api_end_point(end_point)).
      with(api_request_headers(data: data)).
      to_return(response_with(filename: filename, status: status))
  end

  def resource_params(options)
    options.map { |key, value| [key, value].join("=") }.join("&")
  end

  def plan_end_point
    "import/plans"
  end

  def invoice_end_point(customer_uuid)
    ["import", "customers", customer_uuid, "invoices"].join("/")
  end

  def transaction_end_point(invoice_uuid)
    ["import", "invoices", invoice_uuid, "transactions"].join("/")
  end

  def subscription_end_point(customer_uuid)
    ["import", "customers", customer_uuid, "subscriptions"].join("/")
  end

  def search_end_point
    "customers/search"
  end

  def api_end_point(end_point)
    [Chartmogul.configuration.api_host, end_point].join("/")
  end

  def api_request_headers(data:)
    Hash.new.tap do |request_headers|
      request_headers[:headers] = authentication_header

      unless data.nil?
        request_headers[:body] = data.to_json
      end
    end
  end

  def authentication_header
    {
      "Authorization" => "Basic QUNDT1VOVF9UT0tFTjpBQ0NPVU5UX1NFQ1JFVF9LRVk=",
      "Content-Type" => "application/json"
    }
  end

  def response_with(filename:, status:)
    { body: fixture_file(filename), status: status }
  end

  def fixture_file(filename)
    File.read "./spec/fixtures/#{filename}.json"
  end
end
