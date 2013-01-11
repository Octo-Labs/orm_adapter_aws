# OrmAdapterAws

A SimpleDB (vida AWS::Record::Model) adapter for the orm_adapter gem.

## Installation

Add this line to your application's Gemfile:

    gem 'orm_adapter_aws'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orm_adapter_aws

## Usage

This gem was created as a mean of using Devise with SimpleDB.  Please
see _article coming soon about how to use this gem with devise_.

## Thanks

Development of this gem was generously sponsored by _company name
withheld pending approval from the legal department_.

## Testing

This gem relies on the `example_app_shared` set of examples from
`orm_adapter`.  Those examples test some functionality that is not
supplied by SimpleDB, so those tests are failing.  Be aware of then
when running the specs.  Again, *some test failures are expected*. 

```bash
$ rspec spec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
