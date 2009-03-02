desc 'Generates ObjectiveResource files based on routes.rb'
namespace :objective_resource do
  task :generate => :environment do
    collector = ModelCollector.new
    # build all the model files
    collector.collect(ActionController::Routing::Routes.routes).each do |key,value|
      ObjectiveTemplate.generate_model(value)
    end
    # build the setup
    ObjectiveTemplate.generate_setup   
  end
end
