# ObjectiveGenerator
module ObjectiveGenerator
  OR_PLUGIN_PATH = File.join(RAILS_ROOT,"vendor","plugins","objective_generator")
  IGNOREABLE_ROUTE_KEYS = [:id, :format, :controller, :action]
  CRUD = ["new" , "create" , "edit" , "update" , "index" , "destroy" , "show"]
  
  module Templates
    MODEL_HEADER = "model.h.erb"
    MODEL_IMPLEMENTATION = "model.m.erb"
    SETUP_HEADER = "ObjectiveResourceSetup.h"
    SETUP_IMPLEMENTATION = "ObjectiveResourceSetup.m"
  end
  
end

require 'type_rosetta'
require "erb"
require "found_models"
require "found_model"
require "model_collector"
require 'ftools'
