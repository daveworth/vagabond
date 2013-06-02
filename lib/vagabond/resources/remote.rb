require 'vagabond/resources'
require 'vagabond/resources/remote/resource'

module Vagabond
  module Resources
    module Remote
      def port_and_service_scan(options={})
        Vagabond::Resources::Remote::Nmap.new(options)
      end

      def webapp(name, options = {})
        include Capybara::DSL
        webapp = Vagabond::Resources::Remote::Webapp.new(name, options)
        Capybara.current_driver = :webkit
        Capybara.run_server     = false
        Capybara.app_host       = webapp.url
      end
    end
  end
end
