module Vagabond
  module Resources
    class Package < Resource
      attr_accessor :name

      def initialize(name, options = {})
        @name = name
      end

      def state
        aptitude.match(/^State: (.*)$/)[1] rescue nil
      end

      def version
        aptitude.match(/^Version: (.*)$/)[1] rescue nil
      end

      private
      def aptitude
        results = `sudo aptitude show #{@name}`
        if $? == 0
          results
        else
          ""
        end
      end
    end
  end
end
