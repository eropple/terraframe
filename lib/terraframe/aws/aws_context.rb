require 'terraframe/context'
require 'terraframe/provider'

require 'terraframe/aws/aws_resources'

module Terraframe
  module AWS
    class AWSContext < Context
      RESOURCES = {
        :aws_autoscaling_group => Terraframe::AWS::AWSResource,
        :aws_db_instance => Terraframe::AWS::AWSResource,
        :aws_db_security_group => Terraframe::AWS::AWSResource,
        :aws_db_subnet_group => Terraframe::AWS::AWSResource,
        :aws_db_parameter_group => Terraframe::AWS::AWSResource,
        :aws_eip => Terraframe::AWS::AWSResource,
        :aws_elb => Terraframe::AWS::AWSResource,
        :aws_internet_gateway => Terraframe::AWS::AWSResource,
        :aws_launch_configuration => Terraframe::AWS::AWSResource,
        :aws_network_acl => Terraframe::AWS::AWSResource,
        :aws_key_pair => Terraframe::AWS::AWSResource,
        :aws_route_table_association => Terraframe::AWS::AWSResource,
        :aws_route53_record => Terraframe::AWS::AWSResource,
        :aws_route53_zone => Terraframe::AWS::AWSResource,
        :aws_s3_bucket => Terraframe::AWS::AWSResource,

        :aws_instance => Terraframe::AWS::AWSTaggedResource,
        :aws_route_table => Terraframe::AWS::AWSTaggedResource,
        :aws_security_group => Terraframe::AWS::AWSTaggedResource,
        :aws_subnet => Terraframe::AWS::AWSTaggedResource,
        :aws_vpc => Terraframe::AWS::AWSTaggedResource
      }

      def provider_type
        Terraframe::Provider
      end

      def resources
        RESOURCES
      end
    end
  end
end