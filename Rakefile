require 'rubygems'
require 'vagrant'


namespace :vagabond do
  task :full_spec => [:cleanup, :spec]
  
  desc "Remove existing vagrant vm"
  task :cleanup do
    env = Vagrant::Environment.new
    puts "vagrant destroy"
    env.cli("destroy")
  end
  
  desc "Run specs on vagabond"
  task :spec do
    env = Vagrant::Environment.new
    puts "vagrant up"
    env.cli("up")
    puts "vagrant provision"
    env.cli("provision")
    env.vms.each do | name, vm |
      vm.channel.execute("cd /vagrant && rspec spec/*_spec.rb") do |output_handle, data|
        puts data
      end
    end
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
