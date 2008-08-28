module Surveillance
  module WatcherMethods 
   
    def create_call_hash(action, sym, args, return_value, block)
      {:action => action, :class => self.class, :method => sym, :args => args, :return => return_value, :block => block, :time => Time.now}
    end

  end  
end
