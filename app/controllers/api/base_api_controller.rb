# frozen_string_literal: true

module Api
  class BaseApiController < ApplicationController
    include ResponseHandler
  end
end
