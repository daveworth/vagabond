module Vagabond
  module Resources
    class Gem < Resource
      attr_accessor :name

      def initialize(name, options = {})
        @name = name
      end

      def state
        `gem list -i #{@name}`
        if $? == 0
          "installed"
        else
          "not installed"
        end
      end
    end
  end
end
