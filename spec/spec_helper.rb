require 'spec'
require 'rubygems'

require File.dirname(__FILE__) + '/../init'
Dir.glob(File.join(File.dirname(__FILE__), '/test_classes/*.rb')).each {|f| require f }

Spec::Runner.configure do |config|
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end
