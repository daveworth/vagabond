module Vagabond
  module Resources
    class Service < Resource
      attr_accessor :name

      def initialize(name)
        @name = name
      end
    end
  end
end

