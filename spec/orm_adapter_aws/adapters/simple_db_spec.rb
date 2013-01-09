require 'spec_helper'
require 'orm_adapter/../../spec/orm_adapter/example_app_shared'

if !defined?(AWS::Record::Model) #|| !(Mongo::Connection.new.db('orm_adapter_spec') rescue nil)
  puts "** require 'aws-sdk' to run the specs in #{__FILE__}"
else  
  
  #Mongoid.configure do |config|
    #config.master = Mongo::Connection.new.db('orm_adapter_spec')
  #end
  
  
    class User < AWS::Record::Model
      string_attr :name
      integer_attr :rating
      #has_many_related :notes, :foreign_key => :owner_id, :class_name => 'MongoidOrmSpec::Note'
      def self.create!(args)
        u = User.new(args)
        u.save
        u
      end
    end

    class Note < AWS::Record::Model
      string_attr :body #, :default => "made by orm"
      #belongs_to_related :owner, :class_name => 'MongoidOrmSpec::User'
    end
  
  # here be the specs!
  describe AWS::Record::Model::OrmAdapter do
    before do
      User.create_domain
      Note.create_domain
      User.each{|u| u.destroy }
      Note.each{|n| n.destroy }
    end
  
    it_should_behave_like "example app with orm_adapter" do
      let(:user_class) { User }
      let(:note_class) { Note }
    end
  end
  
end
