require 'spec_helper'

describe HangingMethods::MethodCallNotifier do
  describe "#method_missing" do
    let(:return_value) { rand }

    before do
      @notifier = HangingMethods::MethodCallNotifier.new do |*args|
        @callback_args = args
        return_value
      end
    end
    
    subject do
      @notifier.call_a_method('with args')
    end
    
    it "should call block on method call" do
      subject
      expect(@callback_args).to eq([:call_a_method, 'with args'])
    end
    
    it "should return block result" do
      expect(subject).to eq(return_value)
    end
  end
end