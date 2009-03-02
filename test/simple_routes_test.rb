require 'test_helper'

class SimpleRoutesTest < ActiveSupport::TestCase
  
  def setup
    @route_set = ActionController::Routing::RouteSet.new
    @map = ActionController::Routing::RouteSet::Mapper.new(@route_set)
    @map.resources :people do |person|
      person.resources :dogs
    end
    @mc = ModelCollector.new
    @models = @mc.collect(@route_set.routes)
  end
  
  test "collecting models" do
    assert @models.length == 2
  end
  
  test "model relations" do
    @models.each do |key,m|
      case key
      when :Dog
        assert m.belongs_to.size == 1
      when :Person
        assert m.nested_models.size == 1
      end
    end
  end
  
  test "model attributes" do
    dog = @models[:Dog]
    shouldBe = {"name"=>"NSString", "updatedAt"=>"NSDate", 
                "createdAt"=>"NSDate", "dogId"=>"NSNumber", "personId"=>"NSNumber"}
    assert dog.model_attributes == shouldBe
  end

  
end
