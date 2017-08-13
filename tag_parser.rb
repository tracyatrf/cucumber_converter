class TagParser
  RELEVANT_TAGS = { "@javascript" => "js: true", "@bumbleworks" => "bumbleworks: true" } 
  def format_tags(gherkin_tags)
    tags = gherkin_tags.select do |tag|
      RELEVANT_TAGS.keys.include? tag[:name]
    end
    !tags.empty? ? ", #{tags.map{ |tag| RELEVANT_TAGS[tag[:name]] }.join(", ")}": nil
  end
end
