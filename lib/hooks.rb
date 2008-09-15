module Surveillance
  module Hooks

    def acts_as_surveyed(options = {})
      include Surveillance::ClassVariables
      include Surveillance::InstanceMethods
      include Surveillance::WatcherMethods
      extend Surveillance::ClassMethods

      read_options(options)
    end

    def is_being_watched(options = {})
      include Surveillance::ClassVariables
      include Surveillance::InstanceMethods
      include Surveillance::WatcherMethods
      extend Surveillance::ClassMethods
      include Surveillance::HookMethods

      read_options(options)
    end
   
    def is_not_being_watched
      pop_wrap_watcher 
    end   

  end
end
