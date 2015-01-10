require 'terraframe/context'
require 'terraframe/provider'

module Terraframe
  module Contexts
    class AWSContext < Context
      RESOURCES = [
        :aws_instance
      ]

      def provider_type
        Terraframe::Provider
      end

      def resources
        RESOURCES
      end
    end
  end
end