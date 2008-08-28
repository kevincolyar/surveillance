module Surveillance
  module HookMethods
 
    def self.included(base)
      base.hook_methods base
    end

  end
end
