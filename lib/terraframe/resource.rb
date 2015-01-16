require 'terraframe/script_item'

module Terraframe
  class Resource < Terraframe::ScriptItem
    attr_reader :resource_name

    def initialize(resource_name, vars, context, &block)
      @resource_name = resource_name
      super(vars, context, &block)
    end

    def connection(&block)
      connection_set = Connection.new(vars, context, &block)
      @fields["connection"] = connection_set.fields
    end

    def provisioner(provisioner_type, &block)
      provisioner_type = provisioner_type.to_sym

      @fields["provisioner"] = @fields["provisioner"] || []

      provisioner_set = Provisioner.new(vars, context, &block)
      @fields["provisioner"] << { cleanup_provisioner_type(provisioner_type) => provisioner_set.fields }
    end

    def cleanup_provisioner_type(provisioner_type)
      case provisioner_type.to_sym
      when :remote_exec
        "remote-exec"
      when :local_exec
        "local-exec"
      else
        provisioner_type
      end
    end
  end

  

  class Provisioner < Terraframe::ScriptItem
    def connection(&block)
      connection_set = Connection.new(vars, context, &block)
      @fields["connection"] = connection_set.fields
    end
  end
  class Connection < Terraframe::ScriptItem
  end
end