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

      method_name_and_args.size
    end
  end

  class SubTestObject < TestObject
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
      context "with no subclassing" do
        let!(:method_1_return) { client.add_more.a_method }
        let!(:method_2_return) { client.add_more.another_method('arg1', 'arg2') }
        
        it "should add invocation" do
          subject
          expect(client.add_more_invocations).to eq [[:a_method], [:another_method, 'arg1', 'arg2']]
        end

        it "should return the value of the after_invocation method" do
          expect(method_1_return).to eq 1
          expect(method_2_return).to eq 3
        end
      end

      context "with subclass object" do
        let(:client) { SubTestObject.new }
        let!(:method_1_return) { client.add_more.a_method }

        it "should add invocation to the hanging method name owner class, not the sublcass" do
          subject
          expect(client.add_more_invocations).to eq [[:a_method]]
        end
      end
    end
  end
end
