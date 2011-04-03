module WordWrap

  def wrap(width=78)
    gsub(/\s+/, " ").gsub(/(.{1,#{width}})( |\Z)/, "\\1\n")
  end

end
