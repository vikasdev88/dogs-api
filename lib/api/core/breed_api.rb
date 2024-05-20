module Api
  module Core
    # Handles API functionality related to dog breeds.
    class BreedApi < Base
      def initialize(base_url)
        super() # Call the initialize method of the parent class
        parse_url = url_parser(base_url)
        @conn = initialize_request(parse_url)
      end

      def initialize_request(base_url)
        Faraday.new(base_url) do |faraday|
          faraday.headers = headers
          faraday.request :url_encoded
          faraday.options[:open_timeout] = 10
          faraday.options[:timeout] = 120
          faraday.ssl[:verify] = false
          faraday.adapter Faraday.default_adapter
        end
      end

      # Fill free to add your custom methods just like get
      def get(path)
        @conn.get do |request|
          request.url path
        end
      end

      private

      def headers
        {
          'Content-Type' => 'application/json',
        }
      end

      def url_parser(url)
        URI.parse(url)
      end
    end
  end
end
