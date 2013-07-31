require 'spec_helper'

describe HangingMethods::MethodCallNotifier do
  describe "#method_missing" do
    before do
      @notifier = HangingMethods::MethodCallNotifier.new do |*args|
        @callback_args = args
      end
    end
    
    subject do
      @notifier.call_a_method('with args')
    end
    
    it "should call block on method call" do
      subject
      expect(@callback_args).to eq([:call_a_method, 'with args'])
    end
    
    it "should return the notifier" do
      expect(subject).to eq(@notifier)
    end
  end
end