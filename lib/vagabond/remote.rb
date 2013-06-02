require 'vagrant'

require 'vagabond/matchers/remote'
require 'vagabond/resources/remote'

module Vagabond
  module Remote
    include ::Vagabond::Matchers::Remote
    include ::Vagabond::Resources::Remote

    def ip_address
      # gah... there be dragons!  I just found a way in Irb but there _must_ be
      # a better way using the Gem...
      Vagrant::Environment.new.vms.first.last.config.vm.networks.select { |type, info| type == :hostonly }.first.last.first
    end

    def default_url(protocol = "http")
      "#{protocol}://#{ip_address}"
    end
  end
end
