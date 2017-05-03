module HangingMethods
  class MethodCallNotifier
    def initialize(&callback)
      @callback = callback
    end

    def method_missing(name, *arguments, &block)
      @callback.call(name, *arguments, &block)
    end
  end
end
