class TagParser
  RELEVANT_TAGS = { "@javascript" => "js: true", "@bumbleworks" => "bumbleworks: true" }

  def format_tags(gherkin_tags)
    formatted_tags(gherkin_tags.select{ |tag| RELEVANT_TAGS.keys.include? tag[:name] })
  end

  def formatted_tags(tags)
    return nil if tags.empty?
    ", #{tags.map{ |tag| RELEVANT_TAGS[tag[:name]] }.join(", ")}"
  end
end
