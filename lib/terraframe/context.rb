require 'terraframe/provider'
require 'terraframe/resource'

module Terraframe
  class Context
    def provider_type
      raise "provider_type be implemented in subclassed contexts."
    end
  end
end