require 'objective_generator'

class ModelCollector
  
  attr_accessor :models
  
  def collect(routes)
    @models = FoundModels.new
    routes.each do |route|
      # ignore routes like ':controller/:action/:id' where it could be anything
      unless route.requirements.empty?
        found_model = @models["#{route.requirements[:controller].singularize.camelize}".to_sym]
        found_model.add_route(route)
        # these are the symbols in the route (:id , :action , etc)
        route.significant_keys.each do |key|
          #collect the nested models
          process(found_model,key) unless ObjectiveGenerator::IGNOREABLE_ROUTE_KEYS.include?(key)
        end
      end
    end
    @models
  end
  
  private
  
  def process(model,key)
    begin
    # see if its a model_id key , if so build a parent model
      unless key.to_s.scan("id").empty?
        parent_model = @models[key.to_s.gsub("_id","").camelize.to_sym]
        parent_model.add_child(model)
        model.add_parent(parent_model)
      end
    rescue
      puts "Could not find model matching #{key}"
    end
  end
  
  
end