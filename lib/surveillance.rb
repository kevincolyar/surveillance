module Surveillance 

  def self.included(base)
    #Extending Object with Surveillance class method hooks.    
    base.extend(Surveillance::Hooks) 
  end

end

