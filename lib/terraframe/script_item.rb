require 'json'
require 'hashie/mash'

module Terraframe
  class ScriptItem
    attr_reader :fields
    attr_reader :vars
    attr_reader :context

    def initialize(vars, context, &block)
      @fields = {}
      @context = context
      @vars = Hashie::Mash.new(vars)

      instance_eval &block
    end

    def to_json(*a)
      sanitized = @fields
      sanitized.delete("\#")

      sanitized.to_json(*a)
    end

    ## DSL FUNCTIONS BELOW
    def method_missing(method_name, *args, &block)
      if args.length == 1
        if args[0] == nil
          raise "Passed nil to '#{method_name}'. Generally disallowed, subclass ScriptItem if you need this."
        end

        @fields[method_name.to_sym] = args[0]
      else
        raise "Multiple fields passed to a scalar auto-argument '#{method_name}'."
      end
    end


    def output_of(resource_type, resource_name, output_type)
      "${#{resource_type}.#{resource_name}.#{output_type}}"
    end
    def id_of(resource_type, resource_name)
      output_of(resource_type, resource_name, :id)
    end
  end
end