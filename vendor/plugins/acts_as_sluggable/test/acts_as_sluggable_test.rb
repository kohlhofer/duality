require 'rubygems'
require_gem 'activerecord'
require 'test/unit'
require 'acts_as_sluggable'
require 'active_record_overrides'
require 'init'

class ActsAsSluggableTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_truthiness
    kind_of_true = 'true'
    assert kind_of_true
  end
  
  def test_sluggable_attribute
    assert_equal 'title', Article.sluggable_attribute
  end
  
  def test_change_sluggable_attribute
    old_sluggable_attribute = Article.sluggable_attribute
    Article.sluggable_attribute = 'body'
    article = Article.new(:title => 'David Hasselhoff', :body => 'Ich liebe David Hasselhoff!!')
    article.id = 42
    assert_equal 'ich-liebe-david-hasselhoff', article._slug
    assert_equal '42-ich-liebe-david-hasselhoff', article.to_param
    Article.sluggable_attribute = old_sluggable_attribute
  end
  
  def test_slug
    article = Article.new(:title => 'OMG!! My cat is so cute LOL!!')
    article.id = 42
    assert_equal 'omg-my-cat-is-so-cute-lol', article._slug
    assert_equal '42-omg-my-cat-is-so-cute-lol', article.to_param
  end
  
  def test_make_slug
    article = Article.new(:title => 'OMG!! My cat is so cute LOL!!')
    article.id = 42
    def article.make_slug(string)
      string.gsub(/[^a-zA-Z]+/, '').upcase
    end
    assert_equal 'OMGMYCATISSOCUTELOL', article._slug
    assert_equal '42-OMGMYCATISSOCUTELOL', article.to_param
  end
end


#http://www.bigbold.com/snippets/posts/show/767
ActiveRecord::Base.class_eval do
  alias_method :save, :valid?
  def self.columns() @columns ||= []; end
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
end


class Article < ActiveRecord::Base

  column :id, :integer
  column :title, :string
  column :body, :text

  acts_as_sluggable :with => 'title'

end