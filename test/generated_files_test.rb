require 'test_helper'

class GeneratedFilesTest < ActiveSupport::TestCase
  
  def get_model_files(model)
    ObjectiveTemplate.generate_model(@models[model])
    imp = File.join(ObjectiveGenerator::OR_PLUGIN_PATH,"generated","#{model}.m")
    header = File.join(ObjectiveGenerator::OR_PLUGIN_PATH,"generated","#{model}.h")
    assert File.exists?(imp) 
    assert File.exists?(header)
    [
      (File.open(header, 'r') { |f| f.readlines }).join,
      (File.open(imp, 'r') { |f| f.readlines }).join
    ]
  end

  def setup
    @route_set = ActionController::Routing::RouteSet.new
    @map = ActionController::Routing::RouteSet::Mapper.new(@route_set)
    @map.resources :people , :collection=>{:search=>[:any]} do |person|
      person.resources :dogs , :member => {:pet => :post}
    end
    @mc = ModelCollector.new
    @models = @mc.collect(@route_set.routes)
    @dog_files = get_model_files(:Dog)
    @person_files = get_model_files(:Person)
  end
  
  test "config files exist" do
    ObjectiveTemplate.generate_setup
    assert File.exists?(File.join(ObjectiveGenerator::OR_PLUGIN_PATH,"generated","ObjectiveResourceSetup.m")) 
    assert File.exists?(File.join(ObjectiveGenerator::OR_PLUGIN_PATH,"generated","ObjectiveResourceSetup.h")) 
  end
  
  test "generated dog model files" do
    assert_match /\- \(NSString \*\) nestedPathWithId/ , @dog_files[1]
    assert_match /\- \(BOOL\)postPetWithError\:\(NSError \*\*\)error/ , @dog_files[1]
    assert_match /\- \(BOOL\)postPetWithError\:\(NSError \*\*\)error;/ , @dog_files[0]
  end
  
  test "generated person model files" do
    assert_match /\- \(NSArray \*\)findAllDogs/ , @person_files[1]
    assert_match /\- \(id\)getSearchWithError:\(NSError \*\*\)error/ , @person_files[1]
    assert_match /\- \(id\)getSearchWithError:\(NSError \*\*\)error;/ , @person_files[0]
    assert_match /\- \(BOOL\)postSearchWithError:\(NSError \*\*\)error/ , @person_files[1]
    assert_match /\- \(BOOL\)postSearchWithError:\(NSError \*\*\)error;/ , @person_files[0]    
  end
  
  
end