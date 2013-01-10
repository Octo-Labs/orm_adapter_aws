require 'spec_helper'
require 'orm_adapter/../../spec/orm_adapter/example_app_shared'
# !!!!!!!!!!!!!!!!!!!!!
# Not all features in the orm_adapter/example_app_shared spec are supported by SimpleDB.
# Tests that are known to fail are
# example_app_shared.rb:100 # no associations
# example_app_shared.rb:115 # can only sort by one column
# example_app_shared.rb:151 # no associations
# example_app_shared.rb:160 # can only sort by one column
# example_app_shared.rb:188 # no offset for collections
# example_app_shared.rb:209 # no associations
# example_app_shared.rb:215 # no associations


if !defined?(AWS::Record::Model) #|| !(Mongo::Connection.new.db('orm_adapter_spec') rescue nil)
  puts "** require 'aws-sdk' to run the specs in #{__FILE__}"
else  
  
  #Mongoid.configure do |config|
    #config.master = Mongo::Connection.new.db('orm_adapter_spec')
  #end
    class TestBase < AWS::Record::Model
      ## We have to override == so that we can do comparisons correctly
      def ==(other)
        self.attributes == other.attributes
      end

      def save
        super
        sleep(2) # allow a couple of seconds for SimpleDB to propogate
      end

      def destroy
        super
        sleep(2) # allow a couple of secons for SimpleDB to propogate
      end
    end
  
    class User < TestBase
      string_attr :name
      integer_attr :rating
      #has_many_related :notes, :foreign_key => :owner_id, :class_name => 'MongoidOrmSpec::Note'
    end

    class Note < TestBase
      string_attr :body #, :default => "made by orm"
      string_attr :owner_id
      #belongs_to_related :owner, :class_name => 'MongoidOrmSpec::User'

      def owner=(owner)
        owner_id = owner.id
        save
      end
      
    end
  
  # here be the specs!
  describe AWS::Record::Model::OrmAdapter do
    before do
      User.create_domain
      Note.create_domain
      User.each{|u| u.destroy }
      Note.each{|n| n.destroy }
      sleep(2)
    end
  
    it_should_behave_like "example app with orm_adapter" do
      let(:user_class) { User }
      let(:note_class) { Note }
      def create_model(klass, attrs = {})
        if klass == User
          attrs = {:name => "Test User"}.merge(attrs)
        elsif klass == Note
          attrs = {:body => "made by orm"}.merge(attrs)
        end
        model = klass.new(attrs)
        model.save
        model
      end

      def reload_model(model)
        model.class.find(model.id)
      end
    end
  end
  
end
