require 'test_helper'

class SyntaxTest  < ActiveSupport::TestCase
  
  def setup
    @route_set = ActionController::Routing::RouteSet.new
    @map = ActionController::Routing::RouteSet::Mapper.new(@route_set)
    @map.resources :people do |person|
      person.resources :dogs
    end
    @mc = ModelCollector.new
    @models = @mc.collect(@route_set.routes)
  end
  
  test "property generation" do
    gen = ObjectiveSyntax.properties(@models[:Dog].model_attributes)
    assert_match /@property\(nonatomic, retain\) NSNumber\* dogId;/ , gen
  end
  
  test "interface generation" do
    gen = ObjectiveSyntax.interface(@models[:Dog].model_attributes)
    assert_match /NSNumber\* dogId;/, gen
  end
  
end