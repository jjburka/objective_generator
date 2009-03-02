require 'test_helper'

class RoutesWithAddedCollectionsTest  < ActiveSupport::TestCase
  
  def setup
    @route_set = ActionController::Routing::RouteSet.new
    @map = ActionController::Routing::RouteSet::Mapper.new(@route_set)
    @map.resources :people , :collection=>{:search=>[:any]} do |person|
      person.resources :dogs , :member => {:pet => :post}
    end
    @mc = ModelCollector.new
    @models = @mc.collect(@route_set.routes)
  end
  
  test "collecting dog non-standard routes" do
    dog = @models[:Dog]
    assert dog.routes.size == 1
    assert dog.routes[0].requirements[:action] == "pet"
  end
  
  test "collection person non-standard routes" do
    person = @models[:Person]
    assert person.routes.size == 1
    assert person.routes[0].requirements[:action] == "search"    
  end
  
end