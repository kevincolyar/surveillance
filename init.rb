# Include hook code here
#require File.dirname(__FILE__) + '/lib/acts_as_watched'
Dir.glob(File.join(File.dirname(__FILE__), '/lib/*.rb')).each {|f| require f }

Object.send :include, Surveillance 
