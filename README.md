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

Or install it yourself as:

    $ gem install chartmogul

## Configure

Once you have your API keys from ChartMogul, then you can add an initializer
to set your API keys

```ruby
Chartmogul.configure do |config|
  config.account_token = "YOUR_ACCOUNT_TOKEN"
  config.secret_key = "YOUR_SECRET_KEY"
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chartmogul. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[customer listing doc]: https://dev.chartmogul.com/docs/list-all-imported-customers
