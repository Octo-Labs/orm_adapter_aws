require "orm_adapter_aws/version"
require "orm_adapter"
module OrmAdapterAws
  # Your code goes here...
end

puts "!!!!!!!"
if defined?(AWS::Record::Model)
  require 'orm_adapter_aws/adapters/simple_db'
else
  puts "can't load our stuff!!!!!!"
end
