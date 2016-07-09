require "json"

module Chartmogul
  class Response
    def self.parse_json(response)
      JSON.parse(
        response, object_class: Chartmogul.configuration.response_klass
      )
    rescue TypeError, JSON::ParserError
      response
    end
  end

  class ResponseObject < OpenStruct; end
end
