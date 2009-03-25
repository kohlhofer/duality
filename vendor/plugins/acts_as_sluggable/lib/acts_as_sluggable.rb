# ActsAsSluggable

module FleskPlugins

  module ActsAsSluggable
  
    def self.included(base)#:nodoc:
      base.send(:extend, ClassMethods)
    end
    
    module ClassMethods
    
      #Create a "sluggable_attribute" accessor on the
      #model class.
      def self.extended(base)
        class << base
          self.instance_eval do
            attr_accessor :sluggable_attribute
          end
        end
      end
    
      #Make this class behave sluggish. Takes an options hash.
      #options[:with] is the name of the attribute you want to
      #create the slug from. E.g. acts_as_sluggable :with => 'title'
      def acts_as_sluggable(options = {})
        self.sluggable_attribute = options[:with].to_s if options[:with]
        self.send(:include, InstanceMethods)
      end
    
    end
    
    module InstanceMethods
      
      #Retrieve this instance's slug
      def _slug
        @_slug ||= make_slug(
          self.class.sluggable_attribute ?
            self.send(self.class.sluggable_attribute) :
            ''
        )
      end
      
      #Set this instance's slug.
      def _slug=(slug)
        @_slug = slug
      end
      
      #Transform the initial string to the final slug. Override this
      #to change the way slugs are created.
      def make_slug(string)
        string.to_s.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/-+$/, '').gsub(/^-+$/, '')
      end
      
      #Create the :id parameter for a URL. This method is called
      #when using url_for etc and passing a model instance as
      #the :id parameter. E.g.
      #link_to 'Show article', :action => 'show', :id => article
      def to_param
        self._slug.blank? ? id.to_s : "#{id}-#{self._slug}"
      end
    
    end
  
  end

end