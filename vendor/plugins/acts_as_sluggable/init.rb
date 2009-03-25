require 'acts_as_sluggable'
require 'active_record_overrides'

class ActiveRecord::Base
  include FleskPlugins::ActsAsSluggable
end