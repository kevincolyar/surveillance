require File.dirname(__FILE__) + '/../spec_helper'

describe 'Surveillance using StringRecorder' do
 
  setup do
    @gun = Gun.new
    @string_recorder = StringRecorder.new
    Gun.is_being_watched :with => @string_recorder.method(:write_to_log)
  end
 
  it 'should call a bound watcher method to log a message' do

    @gun.fire
    @string_recorder.log.size.should == 2
    @string_recorder.log[0].class.should == Hash
    
    Gun.is_not_being_watched
  end
  
  it 'should call remove a watcher method' do
    @gun.fire
    @string_recorder.log.size.should == 2
    @string_recorder.log[0].class.should == Hash
    
    Gun.is_not_being_watched
    
    @gun.fire
    @string_recorder.log.size.should == 2
    @string_recorder.log[0].class.should == Hash
  end   
end
