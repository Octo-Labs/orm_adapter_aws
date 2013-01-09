module OrmAdapterAws
  class SimpleDB < ::OrmAdapter::Base

    # Return list of column/property names
    def column_names
      klass.attributes.keys
    end

    # @see OrmAdapter::Base#get!
    def get!(id)
      klass.find(wrap_key(id))
    end

    # @see OrmAdapter::Base#get
    def get(id)
      klass.find(wrap_key(id))
    rescue AWS::Record::RecordNotFound => rnf
      nil
    end

    # @see OrmAdapter::Base#find_first
    def find_first(options = {})
      conditions, order = extract_conditions!(options)
      scope = klass.where(conditions_to_fields(conditions))
      scope = scope.order(order) if !order.nil? && order.size > 0
      scope.first
    end

    # @see OrmAdapter::Base#find_all
    def find_all(options = {})
      conditions, order, limit, offset = extract_conditions!(options)
      scope = klass.where(conditions_to_fields(conditions))
      scope = scope.order(order) if !order.nil? && order.size > 0
      scope = scope.limit(limit) if !limit.nil?
      #.offset(offset).all
      scope.all.to_a
    end

    # @see OrmAdapter::Base#create!
    #def create!(attributes = {})
      #klass.create!(attributes)
    #end

    # @see OrmAdapter::Base#destroy
    def destroy(object)
      object.destroy && true if valid_object?(object)
    end

    protected

    # Introspects the klass to convert and objects in conditions into foreign key and type fields
    def conditions_to_fields(conditions)
      conditions.inject({}) do |fields, (key, value)|
        fields.merge(key => value)
      end
    end

    def order_clause(order)
      order.map {|pair| "#{pair[0]} #{pair[1]}"}.join(",")
    end

  end
end

AWS::Record::Model::OrmAdapter = OrmAdapterAws::SimpleDB
module AWS
  module Record
    class Model
      extend ::OrmAdapter::ToAdapter
    end
  end
end


