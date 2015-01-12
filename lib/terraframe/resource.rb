require 'terraframe/script_item'

module Terraframe
  class Resource < Terraframe::ScriptItem
    attr_reader :resource_name

    def initialize(resource_name, vars, &block)
      @resource_name = resource_name
      super(vars, &block)
    end
  end
end