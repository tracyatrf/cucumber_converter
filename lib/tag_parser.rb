class TagParser
  def format_tags(gherkin_tags)
    return nil if tags.empty?
    ", #{tags.map{ |tag| Config.tags[tag[:name]] || tag }.join(", ")}"
  end
end
