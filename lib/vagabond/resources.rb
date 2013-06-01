$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'resources'))

module Vagabond
  module Resources
    class Resource
      def title
        @name
      end

      def to_s
        klass_name = self.class.to_s.split(/::/)[-1].downcase
        "#{klass_name}(#{title})"
      end
    end
  end
end

require 'vagabond/resources/file'
require 'vagabond/resources/gem'
require 'vagabond/resources/package'
require 'vagabond/resources/service'
require 'vagabond/resources/user'
require 'vagabond/resources/nmap'

module Vagabond
  module Resources
    def file(name, options = {})
      Vagabond::Resources::File.new(name, options)
    end

    def gem(name, options = {})
      Vagabond::Resources::Gem.new(name, options)
    end

    def package(name, options = {})
      Vagabond::Resources::Package.new(name, options)
    end

    def service(name)
      Vagabond::Resources::Service.new(name)
    end

    def user(name, options = {})
      Vagabond::Resources::User.new(name, options)
    end

    def nmap(name, options = {})
      Vagabond::Resources::Nmap.new(options)
    end
  end
end
