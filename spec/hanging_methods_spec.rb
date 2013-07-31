require 'spec_helper'

describe HangingMethods do
  class TestObject
    include HangingMethods
    
    add_hanging_method :add
    add_hanging_method :add_more, after_invocation: :add_more_after_invocation
    
    def add_more_invocations
      @add_more_invocations ||= []
    end
    
    private
    
    def add_more_after_invocation(method_name_and_args)
      add_more_invocations << method_name_and_args
    end
  end
  
  describe "#hanging_method_invocations" do
    let(:client) { TestObject.new }
    
    subject do
      client.hanging_method_invocations(:add)
    end
    
    context "with invocations" do
      before do
        client.add.a_method
        client.add.another_method('arg1', 'arg2')
      end
      
      it "should add invocation" do
        expect(subject).to eq [[:a_method], [:another_method, 'arg1', 'arg2']]
      end
    end
    
    context "with after_invocation" do
      before do
        client.add_more.a_method
        client.add_more.another_method('arg1', 'arg2')
      end
      
      it "should add invocation" do
        subject
        expect(client.add_more_invocations).to eq [[:a_method], [:another_method, 'arg1', 'arg2']]
      end
    end
  end
end
