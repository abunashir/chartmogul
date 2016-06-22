# Chartmogul

[![Build
Status](https://travis-ci.org/abunashir/chartmogul.svg?branch=master)](https://travis-ci.org/abunashir/chartmogul)
[![Code
Climate](https://codeclimate.com/github/abunashir/chartmogul/badges/gpa.svg)](https://codeclimate.com/github/abunashir/chartmogul)

Chartmogul client library in Ruby

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

## Usage

### Data Sources

Data sources represent sources of billing data for your ChartMogul account. If
you bill your customers using different systems, then you would want to create
a separate data_source object for each system.


#### Create a Data Source

You can create a new data source as simple as

```ruby
Chartmogul::Import::DataSource.create(name: "unique_data_source_name")
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chartmogul. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
