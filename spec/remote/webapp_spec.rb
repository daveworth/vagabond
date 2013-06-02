$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond/resources/remote'
include Vagabond::Resources::Remote

describe "Testing Apache's default landing page" do
  let(:default_landing_page_copy) { "It works!" }

  describe webapp("http://10.1.1.2") do
    it "should have a landing page" do
      visit "/"
      page.should have_content default_landing_page_copy
    end
  end

  describe webapp("apache_app", url: "http://10.1.1.2") do
    it "should have a landing page" do
      visit "/"
      page.should have_content default_landing_page_copy
    end
  end
end
