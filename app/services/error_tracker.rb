# frozen_string_literal: true

class ErrorTracker
  def initialize(errors = [])
    @errors = errors
  end

  def list_errors
    @errors.join(', ')
  end

  def add_error(error)
    @errors.push(error)
  end

  def any?
    @errors.empty?
  end

  def success
    any?
  end
end
