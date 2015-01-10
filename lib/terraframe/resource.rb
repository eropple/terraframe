require 'terraframe/script_item'

module Terraframe
  class Resource < Terraframe::ScriptItem
    def resource_type
      raise "resource_type must be overridden in inheriting classes."
    end
  end
end