module TypeRosetta
  
  POINTER_TYPES = {
    :datetime  => "NSDate",
    :date      => "NSDate",
    :string    => "NSString",
    :integer   => "NSNumber",
    :float     => "NSDecimalNumber",
    :double    => "NSDecimalNumber"
  }
  
  def convert_model(attributes={})
    translated_model = Hash.new
    attributes.each do |name , data|
      translated_model[translate_name(name)] = translate_type(data.type)
    end
    translated_model
  end
  
  def translate_type(ruby_type)
    POINTER_TYPES.include?(ruby_type) ? POINTER_TYPES[ruby_type] : POINTER_TYPES[:string]
  end
  
  def translate_name(ruby_name)
    ruby_name = "#{@model_name}_id" if ruby_name == "id"
    ruby_name.camelize(:lower)
  end
  
end