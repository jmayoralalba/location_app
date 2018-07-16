ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def assert_error(record, options)
    assert_not record.valid?

    options.each do |attribute, message|
      assert record.errors.added?(attribute, message), "Expected #{attribute} to have the following error: #{message}"
    end
  end
end
