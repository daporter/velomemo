class String

  if instance_methods.include?(:word_wrap)
    raise "Method 'word_wrap' exists. String Extensions will not override!"
  end

  def word_wrap(width=78)
    gsub(/\s+/, " ").gsub(/(.{1,#{width}})( |\Z)/, "\\1\n")
  end

end
