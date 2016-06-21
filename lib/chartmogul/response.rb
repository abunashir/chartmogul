require "json"

module Chartmogul
  class Response
    def self.parse_json(response)
      JSON.parse(response, object_class: OpenStruct)
    end
  end
end
