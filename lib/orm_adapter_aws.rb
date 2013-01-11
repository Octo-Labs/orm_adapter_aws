require "orm_adapter_aws/version"
require "orm_adapter"
module OrmAdapterAws
end

if defined?(AWS::Record::Model)
  require 'orm_adapter_aws/adapters/simple_db'
end
