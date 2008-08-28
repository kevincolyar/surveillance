
class StringRecorder
  attr_accessor :log
 
  def initialize
    @log = [] 
  end
 
  def write_to_log(message)
    @log << message 
  end
end
