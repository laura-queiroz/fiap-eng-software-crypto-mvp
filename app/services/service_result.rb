# frozen_string_literal: true

ServiceResult = Struct.new(:success?, :data, :errors, :error_code, keyword_init: true) do
  def self.success(data)
    new(success?: true, data: data, errors: nil, error_code: nil)
  end

  def self.failure(errors:, error_code: nil)
    new(success?: false, data: nil, errors: errors, error_code: error_code)
  end

  def self.not_found
    new(success?: false, data: nil, errors: "Not found", error_code: :not_found)
  end

  def errors_as_hash?
    errors.is_a?(Hash)
  end
end
