module Vagabond
  module Matchers
    module Package
      # be_installed is defined for Packages in Shared

      RSpec::Matchers.define :be_version do |expected|
        match do |actual|
          actual.version == expected
        end

        failure_message_for_should do |actual|
          "expected #{actual.to_s} to be version '#{expected}'"
        end

        failure_message_for_should_not do |actual|
          "expected #{actual.to_s} to not be version '#{expected}'"
        end
      end
    end
  end
end
