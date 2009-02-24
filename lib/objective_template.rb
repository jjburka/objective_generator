class ObjectiveTemplate
  include ObjectiveGenerator
  
  def self.generate_model(m)
    [Templates::MODEL_HEADER,Templates::MODEL_IMPLEMENTATION].each do |file|
      infile = File.join(OR_PLUGIN_PATH,"templates",file)
      outfile = File.join(OR_PLUGIN_PATH,"generated","#{m.model.name}#{infile.scan(/(\..)\.erb$/).flatten.first}")
      template = String.new
      File.open(infile, 'r') { |f| template = f.readlines }
      File.open(outfile, 'w') {|f| f.write(ERB.new(template.join()).result(m.get_binding)) }
    end
  end
  
  def self.generate_setup
    [Templates::SETUP_HEADER,Templates::SETUP_IMPLEMENTATION].each do |file|
      infile = File.join(OR_PLUGIN_PATH,"templates",file)
      outfile = File.join(OR_PLUGIN_PATH,"generated",file)
      File.copy(infile,outfile)
    end
  end
  
  
  private
  
end