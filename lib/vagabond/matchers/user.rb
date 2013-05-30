require 'pry'
module Vagabond
  module Matchers
    module User
      RSpec::Matchers.define :member_of_group? do |expected|
        match do |actual|
          actual.member_of_group?(expected)
        end
      end

      RSpec::Matchers.define :have_shell do |expected|
        match do |actual|
          actual.shell == expected
        end
      end

      RSpec::Matchers.define :have_home_directory do |expected|
        match do |actual|
          actual.homedir == expected
        end
      end
    end
  end
end
