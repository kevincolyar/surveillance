require File.dirname(__FILE__) + '/../spec_helper'

describe Surveillance do 
 
  setup do 
    @gun = Gun.new
    Gun.is_being_watched :with => lambda { |msg| p msg }
  end
  
  it 'should not include Surveillance class variables into Class' do
    Object.class_variables.include?('@@__before_watchers').should == false 
    Object.class_variables.include?('@@__after_watchers').should == false 
    Object.class_variables.include?('@@__alias_watched_methods').should == false  
    Object.class_variables.include?('@@__watch_onlys').should == false 
    Object.class_variables.include?('@@__watch_exceptions').should == false  
  end

  it 'should not include Surveillance class variables into Module' do
    Module.class_variables.include?('@@__before_watchers').should == false 
    Module.class_variables.include?('@@__after_watchers').should == false 
    Module.class_variables.include?('@@__alias_watched_methods').should == false  
    Module.class_variables.include?('@@__watch_onlys').should == false 
    Module.class_variables.include?('@@__watch_exceptions').should == false  
  end

  it 'should include Surveillance class variables in a class definition' do
    Gun.class_variables.include?('@@__before_watchers').should == true
    Gun.class_variables.include?('@@__after_watchers').should == true
    Gun.class_variables.include?('@@__alias_watched_methods').should == true
    Gun.class_variables.include?('@@__watch_onlys').should == true
    Gun.class_variables.include?('@@__watch_exceptions').should == true
  end

  it 'should include Surveillance class when told' do
    Bullet.is_being_watched
    Bullet.class_variables.include?('@@__before_watchers').should == true
    Bullet.class_variables.include?('@@__after_watchers').should == true
    Bullet.class_variables.include?('@@__alias_watched_methods').should == true
    Bullet.class_variables.include?('@@__watch_onlys').should == true
    Bullet.class_variables.include?('@@__watch_exceptions').should == true
    Bullet.is_not_being_watched
  end

  it 'should create a __watched__ method' do
    @gun.methods.include?('__watched__fire').should == true
    @gun.methods.include?('__watched__boom').should == true
    @gun.methods.include?('__watched__shoot_bullet').should == true
  end

  it 'should shoot three bullets' do
    @gun.shoot("one", "two", "three") { puts "hi" }
    Gun.is_not_being_watched
  end

  it 'should calculate a node port' do
    puts "Node Port: #{@gun.calculate_node_port(15, 1)}"
    Gun.is_not_being_watched
  end

end
