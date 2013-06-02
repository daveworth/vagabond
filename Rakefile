require 'rubygems'
require 'vagrant'

namespace :vagabond do
  task :full_spec => [:cleanup, :spec]

  desc "Remove existing vagrant vm"
  task :cleanup do
    env = Vagrant::Environment.new
    puts "vagrant destroy"
    env.cli("destroy -f")
  end

  desc "Run both remote and local specs"
  task :spec => [:local_spec, :remote_spec]

  desc "Run specs on vagabond"
  task :local_spec do
    env = Vagrant::Environment.new
    puts "vagrant up"
    env.cli("up")
    puts "vagrant provision"
    env.cli("provision")
    env.vms.each do | name, vm |
      vm.channel.execute("cd /vagrant && rake spec") do |output_handle, data|
        puts data
      end
    end
  end

  desc "Run specs on Vagrant instance remotely"
  task :remote_spec do
    puts "Running remote specs"
    system "rake remote_spec"
  end
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb'].exclude('spec/remote/*_spec.rb')
  spec.rspec_opts = "--tag ~remote"
end

RSpec::Core::RakeTask.new(:remote_spec) do |spec|
  spec.pattern = FileList['spec/remote/*_spec.rb']
  spec.rspec_opts = "--tag remote"
end
