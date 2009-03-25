module ActiveRecord
  
  class Base
  
  
    def self.find_from_ids_with_coercion(ids, options)
      if ids.first.is_a?(Array)
        ids.first.map!{|id| id.nil? ? id : id.to_i }
      else
        ids.map!{|id| id.nil? ? id : id.to_i }
      end
      find_from_ids_without_coercion(ids, options)
    end
    
    class << self
      alias_method :find_from_ids_without_coercion, :find_from_ids
      alias_method :find_from_ids, :find_from_ids_with_coercion
    end
  

  end
  
end