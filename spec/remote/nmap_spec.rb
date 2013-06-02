$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond/remote'
include Vagabond::Remote

describe port_and_service_scan, :remote => true do
  it { should have_open_port 22     }
  it { should have_open_port "ssh"  }
  it { should_not have_open_port 23 }

  its(:open_port_numbers) { should =~ [22, 80, 111]}

  it { should have_remote_service "OpenSSH" }
  it { should have_remote_service "Apache"  }
  it { should_not have_remote_service "IIS" }

  it { should have_remote_service     "OpenSSH",       on_port: 22 }
  it { should_not have_remote_service "CommercialSSH", on_port: 22 }
  it { should_not have_remote_service "OpenSSH",       on_port: 23 }

  it { should have_remote_service_version     "OpenSSH", "5.3p1"   }
  it { should_not have_remote_service_version "OpenSSH", "0.9beta" }
end
