# frozen_string_literal: true

module Validatable
  def errors
    @validation_errors ||= {}
  end

  def valid?
    @validation_errors = {}
    validate
    @validation_errors.empty?
  end

  def add_error(attribute, message)
    (errors[attribute] ||= []) << message
  end
end
