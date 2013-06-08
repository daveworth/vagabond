require 'rubygems'
require 'vagrant'
require 'erb'

namespace :vagabond do
  task :full_spec => [:cleanup, :spec]

  desc "get cookbooks submodule"
  task :setup do
    sh "git submodule init"
    sh "git submodule update"
  end

  desc "Remove existing vagrant vm"
  task :cleanup do
    env = Vagrant::Environment.new
    puts "vagrant destroy"
    env.cli("destroy","-f")
  end

  desc "Run both remote and local specs"
  task :spec => [:vagrantfile, :vagrant_up, :vagrant_provision, :local_and_remote_specs]
  task :local_and_remote_specs => [:local_spec, :remote_spec]

  task :vagrantfile do
    recipe = ENV['COOKBOOK'] || "vagabond"
    vagrant_file = ERB.new(File.read('Vagrantfile.erb'))
    output = vagrant_file.result(binding)
    File.open("Vagrantfile", 'w') { |f| f.write output }
  end

  task :vagrant_up do
    env = Vagrant::Environment.new
    puts "vagrant up"
    env.cli("up")
  end

  task :vagrant_provision do
    env = Vagrant::Environment.new
    puts "vagrant provision"
    env.cli("provision")
  end

  desc "Run specs on vagabond"
  task :local_spec do
    env = Vagrant::Environment.new
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

  desc "Demonstrate an upgrade between chef cookbook versions"
  task :upgrade_path => [:cleanup, :checkout_v1, :spec, :upgrade_to_v2, :provision_at_test_again]
  task :checkout_v1 do
    puts "getting v1 cookbooks"
    sh "cd chef && git co v1"
  end
  task :upgrade_to_v2 do
    puts "getting v2 cookbooks for upgrade"
    sh "cd chef && git co v2"
  end
  # get around Rake's unwilliness to run tasks twice!
  task :provision_at_test_again do
    sh "rake vagabond:vagrant_provision"
    sh "rake vagabond:local_and_remote_specs"
  end
end

SPEC_PATH = "chef/spec"
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["#{SPEC_PATH}/**/*_spec.rb"].exclude("#{SPEC_PATH}/remote/*_spec.rb")
  spec.rspec_opts = "--tag ~remote"
end

RSpec::Core::RakeTask.new(:remote_spec) do |spec|
  spec.pattern = FileList["#{SPEC_PATH}/remote/*_spec.rb"]
  spec.rspec_opts = "--tag remote"
end
