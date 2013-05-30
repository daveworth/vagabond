$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'resources'))

require 'vagabond/resources/file'
require 'vagabond/resources/gem'
require 'vagabond/resources/package'
require 'vagabond/resources/service'
require 'vagabond/resources/user'

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
  end
end
