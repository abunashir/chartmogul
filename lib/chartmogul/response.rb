require "json"

module Chartmogul
  class Response
    def self.parse_json(response)
      JSON.parse(response, object_class: OpenStruct)
    rescue TypeError, JSON::ParserError
      response
    end
  end
end
