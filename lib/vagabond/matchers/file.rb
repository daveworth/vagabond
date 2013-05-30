require 'etc'

module Vagabond
  module Matchers
    module File
      RSpec::Matchers.define :exist do
        match do |actual|
          ::File.exist? actual.title
        end

        failure_message_for_should do |actual|
          "expected #{actual.to_s} would exist"
        end

        failure_message_for_should_not do |actual|
          "expected #{actual.to_s} would not exist"
        end
      end

      RSpec::Matchers.define :have_owner do |expected|
        match do |actual|
          ::Etc.getpwuid(::File.stat(actual.title).uid).name == expected
        end
      end

      RSpec::Matchers.define :have_group do |expected|
        match do |actual|
          ::Etc.getgrgid(::File.stat(actual.title).gid).name == expected
        end
      end

      RSpec::Matchers.define :have_file_type do |expected|
        match do |actual|
          ::File.ftype(actual.title) == expected.to_s
        end

        description do
          "should be a #{expected}"
        end
      end

      RSpec::Matchers.define :have_content do |expected|
        match do |actual|
          expected = /#{expected}/ if expected.kind_of? String
          if expected.options == Regexp::MULTILINE
            ::IO.read(actual.title) =~ expected
          else
            ::File.open(actual.title, "r") do |file|
              file.each_line do |line|
                break(true) if line =~ expected
              end
            end
          end
        end

        description do
          "should contain content matching #{expected}"
        end
      end
    end
  end
end
