# frozen_string_literal: true

module Api
  module V1
    class DogsController < Api::BaseApiController
      before_action :set_breed

      def search_breed
        response = Api::V1::Dogs::GetBreedImage.call(@breed)
        render_json_response(response)
      end

      private

      def set_breed
        breed = dogs_params[:breed]
        return record_not_found(I18n.t('dogs.breed_missing')) if breed.nil?

        @breed = parse_breed(breed)
      end

      def dogs_params
        params.require(:dogs).permit(:breed)
      end

      # Replace 'Boxer 1' with 'Boxer1' to remove unnecessary whitespace and maintain consistent api endpoint.
      def parse_breed(breed)
        breed.gsub(/\s+/, "")
      end
    end
  end
end
