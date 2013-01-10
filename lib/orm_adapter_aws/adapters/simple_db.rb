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
      id = nil
      if conditions.keys.include? :id
        id = conditions.delete(:id)
        obj = get(id)
        compare_obj_to_conditions(obj,conditions)
      else
        scope = klass.where(conditions_to_fields(conditions))
        scope = scope.order(*order_munge(order)) if !order.nil? && order.size > 0
        obj = scope.first
      end
    end

    # @see OrmAdapter::Base#find_all
    def find_all(options = {})
      conditions, order, limit, offset = extract_conditions!(options)
      scope = klass.where(conditions_to_fields(conditions))
      scope = scope.order(*order_munge(order)) if !order.nil? && order.size > 0
      scope = scope.limit(limit) if !limit.nil?
      #.offset(offset).all
      scope.all.to_a
    end

    # @see OrmAdapter::Base#create!
    def create!(attributes = {})
      unless attributes.is_a?(Hash) || valid_object?(attributes)
        raise "#{attributes.class} is not a valid #{klass}."
      end
      obj = klass.new(attributes)
      obj.save
      obj
    end

    # @see OrmAdapter::Base#destroy
    def destroy(object)
      object.destroy && true if valid_object?(object)
    end

    protected
    def compare_obj_to_conditions(obj,conditions)
      return obj if obj.nil?
      atts = obj.attributes
      conditions.each_pair do |k,v|
        return nil unless atts[k] == v
      end
      obj
    end

    # Introspects the klass to convert and objects in conditions into foreign key and type fields
    def conditions_to_fields(conditions)
      conditions.inject({}) do |fields, (key, value)|
        fields.merge(key => value)
      end
    end

    def order_munge(order)
      mung = nil
      if order.is_a?(Array) && order[0].is_a?(Array)
        mung = order[0][0], order[0][1]
      elsif order.is_a? Array
        mung = order[0],order[1]
      else
        mung = order
      end
      mung
      #clause = order.map {|pair| "#{pair[0]} #{pair[1]}"}.join(",")
      #puts "clause = #{clause} -------------"
      #clause
    end

  end
end

AWS::Record::Model::OrmAdapter = OrmAdapterAws::SimpleDB
module AWS
  module Record
    class Model
      extend ::OrmAdapter::ToAdapter

      #def create!(attributes = nil, options = {}, &block)
        #if attributes.is_a?(Array)
          #attributes.collect { |attr| create!(attr, options, &block) }
        #else
          #object = new(attributes, options)
          #yield(object) if block_given?
          #object.save!
          #object
        #end
      #end

    end
  end
end


