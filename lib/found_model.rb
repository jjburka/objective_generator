class FoundModel
  include TypeRosetta
  include ObjectiveGenerator
  attr_accessor :model , :nested_models , :routes , :model_attributes , :belongs_to , :model_name
  
  def initialize(m)
    @nested_models = []
    @routes = []
    @model = m
    @model_attributes = {}
    @belongs_to = []
    @model_name = m.name
    @model_attributes = convert_model(@model.columns_hash)
  end
  
  def add_route(route)
    #only collect non-standard routes
    if !CRUD.include?(route.requirements[:action]) && route.significant_keys.include?(:format)
      @routes << route unless @routes.include?route
    end
  end
  
  def add_child(m)
    @nested_models << m unless @nested_models.include?(m)
  end
  
  def add_parent(m)
    @belongs_to << m unless @belongs_to.include?m  
  end
  
  def get_binding
    binding
  end
  
  
end