class ObjectiveSyntax
  
  def self.interface(variables = {})
    vars = String.new
    variables.each do |name , type|
      vars << self.declaration(name,type)
    end
    vars
  end
  
  def self.declaration(name,type)
    "\t#{type}#{ObjectiveSyntax.type_format(type)} #{name};\n"
  end
  
  def self.property(name,type)
    "@property(nonatomic, #{self.memory_type(type)}) #{type}#{self.type_format(type)} #{name};\n"
  end
  
  def self.properties(variables = {})
    props = String.new
    variables.each do |name , type|
      props << self.property(name,type)
    end
    props
  end
  
  def self.synthesize(variables = {})
    syn = "@synthesize "
    variables.each do |name , type|
      syn << "#{name} ,"
    end
    "#{syn.chop};"
  end
  
  private
  
  def self.memory_type(type)
    self.isPointerType?(type) ? "retain" : "assign"
  end
  
  def self.type_format(type)
    self.isPointerType?(type) ? "*" : " "
  end
  
  def self.isPointerType?(type)
    TypeRosetta::POINTER_TYPES.values.include?(type)
  end
  
end