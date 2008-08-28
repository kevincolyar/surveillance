module Surveillance
  module ClassVariables 
 
    def self.included(klass)

      klass.instance_eval do 
        @@__before_watchers = []
        @@__after_watchers = []
        @@__wrap_watchers = []
        @@__alias_watched_methods = []
        @@__watched_methods = []
        @@__watch_onlys = []
        @@__watch_exceptions = ['current_method', 'current_method__watched__', 'call_wrap_watchers', 'call_before_watchers', 'call_after_watchers', 'call_watch_methods'] 
 
        def method_is_an_exception?(sym)
          return @@__watch_exceptions.include?(sym.to_s)  
        end

        def method_being_watched?(sym)
          return true if sym.to_s =~ /^__watched__/
          return true if instance_methods.include?("__watched__#{sym.to_s}")
          return true if @@__watched_methods.include?(sym.to_s)
          return true if @@__watched_methods.include?("__watched__#{sym.to_s}")
          return false
        end  

        def alias_logged_method(sym)
          @@__watched_methods.push(sym.to_s)
          @@__watched_methods.push("__watched__#{sym.to_s}")

          alias_method('__watched__' + sym.to_s, sym.to_s)
        end

        
       def read_options(options) 
         @@__wrap_watchers.push(options[:with]) if options[:with]
       end

       def pop_wrap_watcher
         @@__wrap_watchers.pop
       end

      end

      klass.class_eval do

        def call_wrap_watchers(action, sym, args, return_value, block)
          call_watch_methods(@@__wrap_watchers, action, sym, args, return_value, block)
          nil
        end
        
        def call_before_watchers(action, sym, args, return_value, block)
          call_watch_methods(@@__before_watchers, action, sym, args, return_value, block)
          nil
        end

        def call_after_watchers(action, sym, args, return_value, block)
          call_watch_methods(@@__after_watchers, action, sym, args, return_value, block)
          nil
        end

        def call_watch_methods(watch_methods, action, sym, args, return_value, block)
          call_hash = create_call_hash(action, sym, args, return_value, block)
          watch_methods.each { |watch_method| watch_method.call(call_hash) }
        end

      end

    end
    
  end
end
