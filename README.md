# ChartMogul

[![Build
Status](https://travis-ci.org/abunashir/chartmogul.svg?branch=master)](https://travis-ci.org/abunashir/chartmogul)
[![Code
Climate](https://codeclimate.com/github/abunashir/chartmogul/badges/gpa.svg)](https://codeclimate.com/github/abunashir/chartmogul)

ChartMogul client library in Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem "chartmogul", github: "abunashir/chartmogul"
```

And then execute:

    $ bundle install

## Configure

Once you have your API keys from ChartMogul, then you can add an initializer
to set your API keys

```ruby
Chartmogul.configure do |config|
  config.account_token = "YOUR_ACCOUNT_TOKEN"
  config.secret_key = "YOUR_SECRET_KEY"

  # Default configurations
  # config.api_host = "https://api.chartmogul.com/v1"
  # config.response_type = "object" [alternative: "hash"]
end
```

## Import API

The Import API allows any subscription business (or subscription billing
platform) to connect with ChartMogul and leverage the powerful analytics that
Chartmogul deliver.

### Data Sources

Data sources represent sources of billing data for your ChartMogul account. If
you bill your customers using different systems, then you would want to create
a separate data source object for each system.

#### Create a Data Source

Creates a data source object for importing data into ChartMogul.

```ruby
Chartmogul::Import::DataSource.create(name: "unique_data_source_name")
```

#### List Data Sources

Lists all data source objects that you have created using the Import API.

```ruby
Chartmogul::Import::DataSource.list
```

#### Delete a Data Source

Delete the specified data source object that was created using the Import
API, and all its associated data.

```ruby
Chartmogul::Import::DataSource.delete(uuid: "data_source_uuid")
```

### Customers

This object represents one of your customers in ChartMogul. You can create
customer objects for both paying and non-paying customers (e.g. leads, free
trials, freemium users, etc.)

#### Import a Customer

Create a `customer` object in ChartMogul under the specified `data_source`.

```ruby
Chartmogul::Import::Customer.create(
  name: "Adam Smith",
  external_id: "customer_001",
  data_source_uuid: "ds_uuid_001",
  email: "adam@smith.com",
  city: "New York",
  state: "NY",
  zip: "ABC123",
  country: "US",
  company: "ChartMogul"
)
```

#### List Customers

Retrieve a list of customer objects created using the Import API.

```ruby
Chartmogul::Import::Customer.list(listing_options = {})
```

Please checkout [customer listing doc] for supported `listing_options`.

#### Delete a Customer

Delete the specified `customer` object that was created using the Import API,
and all its associated data.

```ruby
Chartmogul::Import::Customer.delete(uuid: "customer_uuid")
```

### Plans

This object represents a subscription billing plan for products or services that
you offer your customers. For example, you might have a $50 monthly plan with a
set of features, and a $500 annual plan.

#### Import a Plan

Create a `plan` object in ChartMogul under the specified `data_source`.

```ruby
Chartmogul::Import::Plan.create(
  data_source_uuid: "ds_uuid_001",
  name: "Bronze Plan",
  interval_count: 1,
  interval_unit: "month",
  external_id: "plan_001"
)
```

#### List Plans

Retrieve a list of plan objects created using the Import API. Checkout
[plan listing doc] for supported `listing_options`.

```ruby
Chartmogul::Import::Plan.list(listing_options = {})
```

### Invoices

Invoices are crucial objects in ChartMogul. We auto-generate subscriptions
and metrics from the information contained in these objects. They contain
information about the customer who was billed, the items that were included,
and the transactions related to the invoice.

#### Import Invoices

Create invoices for a given customer. ChartMogul auto-generates subscription
from these invoices. Ref: [Create Invoice API]

```ruby
# Creating a single invoice for a specified customer
#
# If you want to create multiple invoices in one request, then pass an
# Array as `invoice: [invoice_attributes, another_invoice_attributes]`

Chartmogul::Import::Invoice.create(
  customer_uuid: customer_uuid, invoice: invoice_attributes
)

# Pay close attention to the construction of this object.
#
# Invoice attributes

invoice_attributes = {
  external_id: "invoice_001",
  currency: "USD",
  date: "2015-11-01 00:00:00",
  due_date: "2015-11-15 00:00:00",
  line_items: [line_item_attributes],
  transactions: [transaction_attributes]
}

# Line Items
# Invoices must contain an array of one or more line items that were
# billed. Line item objects represent the kind of product or service
# being billed, and relevant details about them.

line_item_attributes = {
  type: "one_time",
  description: "Setup Fees",
  amount_in_cents: 2500,
  quantity: 1,
  discount_code: "PSO86",
  discount_amount_in_cents: 500,
  tax_amount_in_cents: 450
}

# Transactions
# Invoices usually always contain an array of one or more transactions
# Transaction objects represent charge or refund attempts related to
# the invoice

transaction_attributes = {
  date: "2015-11-05 00:14:23",
  type: "payment",
  result: "successful"
}
```

#### List Customer's Invoices

List the invoices of a specified customer

```ruby
Chartmogul::Import::Invoice.list(
  customer_uuid: customer_uuid, page: 1, per_page: 20
)
```

### Transactions

This object represents a payment or refund attempt on an invoice. You can add
any number of successful and failed transaction attempts on an invoice to
ChartMogul. Transaction objects influence Cash Flow metrics in your ChartMogul
account.

#### Import an Invoice Transaction

Create a new transaction object for an invoice imported using the Import API.

```ruby
Chartmogul::Import::Transaction.create(
  type: "refund",
  invoice_uuid: "invoice_uuid_001",
  result: "successful",
  date: "2015-12-25 18:10:00",
  external_id: "transaction_001"
)
```

### Subscriptions

Subscription objects are auto-generated from Invoice objects. In ChartMogul,
customers can have multiple subscriptions at the same time. Subscriptions are
created when a customer purchases a plan for the first time. They may be
altered, cancelled and re-activated indefinitely.

#### List Customer's Subscriptions

Retrieve a list of `subscription` objects for a given `customer`. Subscriptions
are auto-generated from invoice objects created using the Import API.

```ruby
Chartmogul::Import::Subscription.list(
  customer_uuid: "customer_uuid_001", page: 1, per_page: 10
)
```

#### Cancel Customer's Subscription

Cancel a subscription that was generated from an imported invoice.

```ruby
Chartmogul::Import::Subscription.cancel(
  uuid: "subscription_uuid_001", cancelled_at: "2016-01-15 00:00:00"
)
```

## Enrichment API

The Enrichment API allows users to enrich their customer information in
ChartMogul, and leverage the powerful segmentation features that we offer.

### Customers

#### Retrieve a Customer

Retrieve a customer object from your ChartMogul account.

```ruby
Chartmogul::Enrichment::Customer.find("customer_uuid")
```

#### Search for Customers

Find a list of all `customer` objects with the specified email address in your
ChartMogul account.

```ruby
Chartmogul::Enrichment::Customer.search(
  email: "adam.smith@example.com"
)
```

#### List all Customers

Retrieve a list of all customer objects in your ChartMogul account.

```ruby
Chartmogul::Enrichment::Customer.list(
  page: 1, per_page: 10
)
```

### Customer Attributes

Customer attributes are metadata that can be used to filter and segment your
customers in ChartMogul.

#### Retrieve Customer's Attributes

Retrieve the list of attributes for a given customer.

```ruby
Chartmogul::Enrichment::Attribute.list(
  customer_uuid: customer_uuid
)
```

### Tags

Tags are a type of customer attribute. Think of them as keywords that can be
used to describe properties of customers. Tags are useful for storing
unstructured information on a `customer` object.

#### Add Tags to a Customer

```ruby
# Add a single tag for a specified customer
#
# If you want to add multiple tag in one request, simply
# pass an Array as `tag: ["tag_one", "tag_two", "tag_three"]`

Chartmogul::Enrichment::Tag.create(
  customer_uuid: customer_uuid, tag: "important"
)
```

#### Add Tags to Customers with email

Adds tags to customers that have the specified email address.

```ruby
# Add a single tag for a specified customer
#
# If you want to add multiple tag in one request, simply
# pass an Array as `tag: ["tag_one", "tag_two", "tag_three"]`

Chartmogul::Enrichment::Tag.create(
  email: "customer@example.com", tag: "important"
)
```

#### Remove Tags from a Customer

Removes tags from a given customer.

```ruby
# Remove a single tag for a specified customer
#
# If you want to remove multiple tag in one request, simply
# pass an Array as `tag: ["tag_one", "tag_two", "tag_three"]`

Chartmogul::Enrichment::Tag.delete(
  customer_uuid: customer_uuid, tag: "important"
)
```

### Custom Attributes

Custom Attributes are a type of customer attribute. They are key-value
metadata that can be used to describe properties of customers. Custom
Attributes are useful for storing structured information on a `customer`.

#### Add Custom Attributes

Adds custom attributes to a given customer.

```ruby
# Add a single custom attribute for a specified customer
#
# If you want to add multiple custom attribute, simply pass in
# an Array as `attribute: [attribute_hash, another_attribute_hash]`

Chartmogul::Enrichment::CustomAttribute.create(
  customer_uuid: customer_uuid,
  attribute: {
    type: "String",
    key: "channel",
    value: "Facebook"
  }
)
```

#### Add Custom Attributes with Email

Adds custom attributes to customers that have the specified email address.

```ruby
# Add a single custom attribute for a specified customer
#
# If you want to add multiple custom attribute, simply pass in
# an Array as `attribute: [attribute_hash, another_attribute_hash]`

Chartmogul::Enrichment::CustomAttribute.create(
  email: "customer@example.com",
  attribute: {
    type: "String",
    key: "channel",
    value: "Facebook"
  }
)
```

#### Update Custom Attributes

Update the custom attributes of a given customer.

```ruby
Chartmogul::Enrichment::CustomAttribute.update(
  customer_uuid: customer_uuid,
  attribute: { key: value, another_key: another_new_value }
)
```

#### Remove Custom Attributes

Removes custom attributes from a given customer.

```ruby
# Remove a single custom attribute form a given customer
#
# If you want to remove multiple custom attributes, simply pass in an
# Array as `attribute: ["attribute_key", "another_attribute_key"]`

Chartmogul::Enrichment::CustomAttribute.delete(
  customer_uuid: customer_uuid, attribute: "attribute_key"
)
```

## Metrics API

The Metrics API allows users to programmatically pull the subscription metrics
that ChartMogul generates.

### Metrics

#### Retrieve all key metrics

Retrieve all key metrics, for the specified time period.

```ruby
Chartmogul::Metric.all_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve MRR

Retrieve the Monthly Recurring Revenue (MRR), for the specified time period.

```ruby
Chartmogul::Metric.mrr_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve ARR

Retrieve the Annualized Run Rate (ARR), for the specified time period.

```ruby
Chartmogul::Metric.arr_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve ARPA

Retrieve the Average Revenue Per Account (ARPA), for the specified time period

```ruby
Chartmogul::Metric.arpa_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve ASP

Retrieve the Average Sale Price (ASP), for the specified time period.

```ruby
Chartmogul::Metric.asp_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve Customer Count

Retrieve the number of active customers, for the specified time period.

```ruby
Chartmogul::Metric.cc_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  interval: "month",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve Customer Churn Rate

Retrieve the Customer Churn Rate, for the specified time period.

```ruby
Chartmogul::Metric.ccr_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve MRR Churn Rate

Retrieve the Net MRR Churn Rate, for the specified time period.

```ruby
Chartmogul::Metric.mrrcr_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

#### Retrieve LTV

Retrieves the Customer Lifetime Value (LTV), for the specified time period.

```ruby
Chartmogul::Metric.ltv_metrics(
  start_date: "2015-05-12",
  end_date: "2016-05-12",
  geo: "US,GB,DE",
  plans: "Bronze Plan"
)
```

### Customers

#### List Customer Subscriptions

Retrieve a list of subscriptions for a given customer.

```ruby
Chartmogul::Metric::Subscription.list(
  customer_uuid: "customer_uuid_001", **listing_options
)
```

#### List Customer Activities

Retrieve a list of activities for a given customer.

```ruby
Chartmogul::Metric::Activity.list(
  customer_uuid: "customer_uuid_001", **listing_options
)
```

## Development

We are following Sandi Metz's Rules for this application, you can read the
[description of the rules here]
(http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers). All new code should follow these rules. If you make changes in a pre-existing
file that violates these rules you should fix the violations as part of
your contribution.


### Setup

* Clone the repository.

```sh
git clone https://github.com/abunashir/chartmogul.git
```

* Setup your environment.

```sh
bin/setup
```

* Run the test suite

```sh
rake
```

### Playbox

* Setup API keys.

```sh
cp .sample.pryrc .pryrc
vim .pryrc
```

* Start your console.

```sh
bin/console
```

* Start playing with it.

```sh
Chartmogul::Import::DataSource.list
```

## Contributing

First, thank you for contributing! We love pull requests from everyone. By
participating in this project, you hereby grant the right to grant or transfer
an unlimited number of non exclusive licenses or sub-licenses to third parties,
under the copyright covering the contribution to use the contribution by all
means.

Here are a few technical guidelines to follow:

1. Open an [issue][issues] to discuss a new feature.
1. Write tests to support your new feature.
1. Make sure the entire test suite passes locally and on CI.
1. Open a Pull Request.
1. [Squash your commits][squash] after receiving feedback.
1. Party!

[issues]: https://github.com/abunashir/chartmogul/issues
[squash]: https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[customer listing doc]: https://dev.chartmogul.com/docs/list-all-imported-customers
[plan listing doc]: https://dev.chartmogul.com/docs/list-all-imported-plans
[Create Invoice API]: https://dev.chartmogul.com/docs/import-customers-invoices
