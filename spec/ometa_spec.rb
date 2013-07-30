require_relative 'spec_helper'

require "ometa"

describe Ometa do
 it "can be created" do
   Ometa.new.must_be_instance_of Ometa
 end
end
