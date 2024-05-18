# frozen_string_literal: true

module Api
  module V1
    module Dogs
      # Service class responsible for fetching an image of a specific dog breed.
      class GetBreedImage < Base
        class << self
          def call(breed, error_tracker = ErrorTracker.new)
            begin
              result = process(breed)
            rescue StandardError => e
              error_tracker.add_error(e.message)
            end

            ServiceResponseBuilder.call(result, error_tracker)
          end

          def process(breed)
            Api::Core::BreedApi.new(DOG_API_BASE_URL)
              .then { |breed_conn| breed_conn.get(url_builder(breed)) }
              .then do |response|
              raise_error_if_response_not_ok(response)
              json_response = JSON.parse(response.body)
              { message: json_response["message"], status: response.status }
            end
          end

          private

          def url_builder(breed)
            "api/breed/#{breed.downcase}/images/random"
          end

          def raise_error_if_response_not_ok(response)
            return if response.status == 200

            raise JSON.parse(response.body)["message"]
          end
        end
      end
    end
  end
end
