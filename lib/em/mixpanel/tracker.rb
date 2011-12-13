require 'base64'
require 'json'

module EM
  module Mixpanel
    class Tracker
      attr_reader :env, :token

      def initialize(token, env)
        @token, @env = token, env
      end

      def track(event, properties={})
        if token and Rails.env.production?
          http = EventMachine::HttpRequest.new('http://api.mixpanel.com/track/').post body: {
            data: encoded_data(event, properties)
          }
        else
          Rails.logger.info "[Mixpanel] #{event} #{properties.to_json}"
        end
      end

      def ip
        env.has_key?("REMOTE_ADDR") ? @env["REMOTE_ADDR"] : '1'
      end

      def default_properties
        {
             ip: ip,
           time: Time.now.to_i,
          token: token
        }
      end

      def encoded_data(event, properties)
        params = {
          event: event,
          properties: default_properties.merge(properties)
        }

        ActiveSupport::Base64.encode64s(JSON.generate(params))
      end
    
    end
  end
end
