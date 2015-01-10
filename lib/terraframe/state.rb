require 'json'

module Terraframe
  class State
    attr_reader :vars
    attr_reader :logger

    def initialize(logger, vars, contexts)
      @logger = logger
      logger.info "Initializing state."

      @vars = vars
      logger.debug "State variables:"
      logger.ap vars, :debug

      @__contexts = contexts

      @__output = {
        :providers => {},
        :provisioners => {},
        :variables => {},
        :resources => {}
      }
    end

    def __build()
      logger.info "Building Terraform script from state."
      logger.debug "Contexts:"
      @__contexts.each { |c| logger.debug " - #{c}" }
      @__output.to_json
    end

    def __apply_script(script_name, script)
      logger.info "Applying script '#{script_name}' to state."
      instance_eval(script, script_name, 0)
      logger.info "Script '#{script_name}' applied successfully."
    end

    ## DSL FUNCTIONS BELOW ##
    def provider(type, &block)
      if !@__contexts[type]
        msg = "Unknown provider type: '#{type}'."
        logger.fatal msg
        raise msg
      end

      if @__output[:providers][type]
        msg = "Duplicate provider type (sorry, blame Terraform): '#{type}'"
        logger.fatal msg
        raise msg
      end

      provider = @__contexts[type].provider_type.new(&block)
      logger.debug "Provider of type '#{type}': #{provider.inspect}"
      @__output[:providers][type] = provider

      provider
    end

    def variable
      msg = "TODO: implement tfvar support."
      logger.fatal msg
      raise msg
    end

    def provisioner
      msg = "TODO: implement provisioner support."
      logger.fatal msg
      raise msg
    end

    def resource(resource_type, resource_name, &block)
      unless @__contexts.any? { |k, v| v.resources.include?(resource_type) }
        logger.warn "Could not find a context that supports resource type '#{resource_type}'. Continuing, but you've been warned."
      end

      @__output[:resources][resource_type] ||= {}
      @__output[:resources][resource_type][resource_name.to_s] = Resource.new(&block)
    end

    # anything that is not a provider or a variable should be interpreted 
    def method_missing(method_name, *args, &block)
      if (args.length != 1)
        msg = "Too many arguments for resource invocation '#{method_name}'."
        logger.fatal(msg)
        raise msg
      end
      resource(method_name.to_sym, args[0], &block)
    end
  end
end