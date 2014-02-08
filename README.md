# OrmAdapterAws

A SimpleDB (via AWS::Record::Model) adapter for the orm_adapter gem.


[![Gem Version](https://badge.fury.io/rb/orm_adapter_aws.png)](http://badge.fury.io/rb/orm_adapter_aws)
[![Code Climate](https://codeclimate.com/repos/52f5dd11e30ba05c5200820a/badges/01e7c4925a3dcf8c01cd/gpa.png)](https://codeclimate.com/repos/52f5dd11e30ba05c5200820a/feed)

## Installation

Add this line to your application's Gemfile:

    gem 'orm_adapter_aws'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orm_adapter_aws

## Usage

This gem was created as a means of using Devise with SimpleDB.  Please see _article coming soon about how to use this gem with devise_.

## Thanks

Development of this gem was generously sponsored by _company name
withheld pending approval from the legal department_.

## Testing

This gem relies on the `example_app_shared` set of examples from
`orm_adapter`.  Those examples test some functionality that is not
supplied by SimpleDB, so those tests are failing.  Be aware of this
when running the specs.  Again, *some test failures are expected*. See
`spec/spec_helper.rb` for a list of specs that are expedted to fail.

Run the tests with : 

```bash
$ rspec spec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
