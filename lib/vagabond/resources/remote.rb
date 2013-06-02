require 'vagabond/resources/remote/webapp'
module Vagabond
  module Resources
    module Remote
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
