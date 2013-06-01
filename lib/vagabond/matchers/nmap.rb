module Vagabond
  module Matchers
    module Nmap
    end
  end

  def port_and_service_scan(options={})
    Vagabond::Resources::Nmap.new(options)
  end
end
