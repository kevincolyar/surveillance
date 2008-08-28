module Surveillance
  module ClassMethods 

    def method_added(sym)
      return if method_is_an_exception? sym 
      return if method_being_watched? sym
      alias_logged_method(sym)
      recreate_method(sym) 
    end

    def method_removed(sym)
      @@__watched_methods.delete_if { |i| i == sym.to_s or i == '__watched__' + sym.to_s }
    end
    
    def recreate_method(sym)
      class_eval <<-EOS 
        def #{sym.to_s}(*args, &block)
          call_wrap_watchers(:start, current_method, args, nil, block)
          call_before_watchers(:start, current_method, args, nil, block)
          ret = send("#{'__watched__' + sym.to_s}".to_sym, *args, &block)
          call_after_watchers(:end, current_method, args, ret, block)
          call_wrap_watchers(:end, current_method, args, ret, block)
          return ret
        end 
      EOS

      #puts "Added method #{sym} to #{self}"
    end
   
  
    def hook_methods(base_class)
      get_unique_methods(base_class).each do |sym|
        next if method_is_an_exception? sym
        next if method_being_watched? sym
        alias_logged_method(sym)
        recreate_method(sym) 
        method_added(sym)
      end
    end

    def get_unique_methods(base_class)
      my_super = base_class.superclass
      ret = my_super ? base_class.instance_methods - my_super.instance_methods : base_class.instance_methods
      ret = ret - ActsAsWatched::WatcherMethods.instance_methods
      ret
    end 
  end
end
