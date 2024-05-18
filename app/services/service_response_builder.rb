# frozen_string_literal: true

class ServiceResponseBuilder < Base
  class << self
    def call(result, error_tracker, code = 200)
      {
        success: error_tracker.success && code == 200,
        errors: error_tracker.list_errors,
        result: error_tracker.success && code == 200 ? result[:message] : nil,
        code: error_tracker.success && code == 200 ? result[:status] : 404,
      }
    end
  end
end
