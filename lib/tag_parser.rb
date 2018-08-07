class TagParser
  def format_tags(tags)
    return nil if tags.empty?
    ", #{tags.map{ |tag| Config.tags[tag[:name]] || tag[:name].tr('@',':') }.join(", ")}"
  end
end
