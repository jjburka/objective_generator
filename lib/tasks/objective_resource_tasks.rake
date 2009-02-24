desc 'Generates ObjectiveResource files based on routes.rb'
namespace :objective_resource do
  task :generate => :environment do
    found_models = FoundModels.new
    ActionController::Routing::Routes.routes.each do |route|
      # ignore routes like ':controller/:action/:id' where it could be anything
      unless route.requirements.empty?
        model_name = "#{route.requirements[:controller].singularize.camelize}".to_sym
        found_model = found_models[model_name]
        
        # these are the symbols in the route (:id , :action , etc)
        route.significant_keys.each do |key|
          #collect the nested models
          unless ObjectiveGenerator::IGNOREABLE_ROUTE_KEYS.include?(key)
            found_model.add_route(route)
            begin
              # see if its a model_id key , if so build a parent model
              unless key.to_s.scan("id").empty?
                belongs_to = key.to_s.gsub("_id","").camelize.to_sym
                parent_model = found_models[belongs_to]
                parent_model.add_child(found_model)
                found_model.add_parent(parent_model)
              end
            rescue
              puts "Could not find model matching #{key}"
            end
          end
        end
      end
    end 
    # build all the model files
    found_models.each do |key,value|
      ObjectiveTemplate.generate_model(value)
    end
    # build the setup
    ObjectiveTemplate.generate_setup   
  end
end
