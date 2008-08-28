require File.dirname(__FILE__) + '/../spec_helper'

require 'builder'

describe 'Surveillance with Builder' do

  setup do
    @logger = BuilderWrapper.new
    @gun = Gun.new
  end

  it 'should output xml' do
    Gun.is_being_watched :with => @logger.method(:log)
    Bullet.is_being_watched :with => @logger.method(:log)

    @gun.fire
    puts "XML:"
    puts "#{@logger.xml.target!}"
  end

end

  
