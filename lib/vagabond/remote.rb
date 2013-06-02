require 'vagabond/matchers/remote'
require 'vagabond/resources/remote'

module Vagabond
  module Remote
    include ::Vagabond::Matchers::Remote
    include ::Vagabond::Resources::Remote
  end
end
