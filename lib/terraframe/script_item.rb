require 'json'

module Terraframe
  class ScriptItem
    attr_reader :fields

    def initialize(&block)
      @fields = {}

      instance_eval &block
    end

    def to_json(*a)
      @fields.to_json(*a)
    end

    ## DSL FUNCTIONS BELOW
    def method_missing(method_name, *args, &block)
      if args.length == 1
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