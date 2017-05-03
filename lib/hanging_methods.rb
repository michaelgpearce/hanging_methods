require 'hanging_methods/version'
require 'hanging_methods/method_call_notifier'

module HangingMethods
  module ClassMethods
    def add_hanging_method(hanging_method_name, options = {})
      unknown_keys = options.keys - [:after_invocation]
      raise ArgumentError, "Unknown keys: #{unknown_keys.join(',')}" unless unknown_keys.empty?

      add_hanging_method_options(hanging_method_name, options)

      define_method(hanging_method_name) do
        ::HangingMethods::MethodCallNotifier.new do |*method_name_and_args, &block|
          add_hanging_method_invocation(hanging_method_name, method_name_and_args, block)
        end
      end
    end

    def add_hanging_method_options(hanging_method_name, options)
      hanging_method_options(hanging_method_name).merge!(options)
    end

    def hanging_method_options(hanging_method_name)
      @hanging_method_options ||= {}
      @hanging_method_options[hanging_method_name] ||= {}
    end
  end

  module InstanceMethods
    def add_hanging_method_invocation(hanging_method_name, method_name_and_args, block)
      hanging_method_invocations(hanging_method_name) << method_name_and_args
      hanging_method_blocks(hanging_method_name) << block

      ret = if after_invocation = self.method(hanging_method_name).owner.hanging_method_options(hanging_method_name)[:after_invocation]
        send(after_invocation, method_name_and_args[0], *method_name_and_args[1..-1], &block)
      end
    end

    def hanging_method_invocations(hanging_method_name)
      @hanging_method_invocations ||= {}
      @hanging_method_invocations[hanging_method_name] ||= []
    end

    def hanging_method_blocks(hanging_method_name)
      @hanging_method_blocks ||= {}
      @hanging_method_blocks[hanging_method_name] ||= []
    end
  end

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.send(:extend, ClassMethods)
  end
end

