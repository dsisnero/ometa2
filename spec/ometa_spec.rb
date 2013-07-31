require_relative 'spec_helper'

require "ometa2"

module OMeta2
   it "can be created" do
   Ometa.new.must_be_instance_of Ometa
 end
end
