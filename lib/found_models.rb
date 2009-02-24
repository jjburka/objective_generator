class FoundModels
  include Enumerable
  
  def initialize()
    @models = {}
  end
  
  def[](model_name)
    @models[model_name] || (@models[model_name] = FoundModel.new(model_name.to_s.constantize))
  end
  
  def each
    @models.each { |name, model| yield name, model }
    self
  end

  def length
    @models.length
  end

end