module Surveillance
  module InstanceMethods
    
    def current_method
      caller[0][/`([^']*)'/, 1]
    end

  end
end
