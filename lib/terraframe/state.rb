require 'json'
require 'hashie/mash'

module Terraframe
  class State
    # TODO: support outputs!

    attr_reader :vars
    attr_reader :logger

    def initialize(logger, vars, contexts)
      @logger = logger
      logger.info "Initializing state."

      @vars = Hashie::Mash.new(vars)
      logger.debug "State variables:"
      logger.ap vars, :debug

      @__contexts = contexts

      @__output = {
        :provider => {},
        :variable => {},
        :resource => {}
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

      if @__output[:provider][type]
        msg = "Duplicate provider type (sorry, blame Terraform): '#{type}'"
        logger.fatal msg
        raise msg
      end

      handling_context = @__contexts[type]
      provider = handling_context.provider_type.new(vars, handling_context, &block)
      logger.debug "Provider of type '#{type}': #{provider.inspect}"
      @__output[:provider][type] = provider

      provider
    end

    def variable
      msg = "TODO: implement tfvar support."
      logger.fatal msg
      raise msg
    end

    def resource(resource_type, resource_name, &block)
      handling_context_pair = @__contexts.find { |k, v| v.resources.include?(resource_type) }
      if handling_context_pair == nil
        msg = "Could not find a context that supports resource type '#{resource_type}'."
        logger.error msg
        raise msg
      end

      handling_context = handling_context_pair[1]
      resource_class = handling_context.resources[resource_type]

      @__output[:resource][resource_type] ||= {}
      @__output[:resource][resource_type][resource_name.to_s] = resource_class.new(resource_name, vars, handling_context, &block)
    end

    # anything that is not a provider or a variable should be interpreted 
    def method_missing(method_name, *args, &block)
      case method_name
        when "vars"
          @vars
        else
          if (args.length != 1)
            msg = "Too many arguments for resource invocation '#{method_name}'."
            logger.fatal(msg)
            raise msg
          end
          resource(method_name.to_sym, args[0], &block)
      end
    end
  end
end