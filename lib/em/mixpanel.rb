require 'base64'
require 'json'
require 'em/mixpanel/version'

module EM
  class Mixpanel
    TRACK_URI = 'http://api.mixpanel.com/track'
    IMPORT_URI = 'http://api.mixpanel.com/import'
    
    attr_reader :token, :default_properties
    
    def initialize(token, default_properties={})
      @token, @default_properties = token, default_properties
    end
    
    def track(event, properties={})
      data = self.class.encode_data(event, {
        token: token,
        time: Time.now.to_i
      }.merge(default_properties).merge(properties))
      
      EM::HttpRequest.new(TRACK_URI.to_s).post(
        body: {data: data},
        query: {ip: 0}
      )
    end
    
    def import(event, properties={})
      data = self.class.encode_data(event, {
        token: token
      }.merge(default_properties).merge(properties))
      
      EM::HttpRequest.new(IMPORT_URI.to_s).get(
        query: {
          data: data,
          api_key: token
        }
      )
    end
    
  private
    
    def self.encode_data(event, properties)
      params = {event: event, properties: properties}
      Base64.strict_encode64 params.to_json
    end
    
  end
end
