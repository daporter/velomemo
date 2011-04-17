module Velomemo
  module String
    def word_wrap(width=78)
      gsub(/\s+/, " ").gsub(/(.{1,#{width}})( |\Z)/, "\\1\n")
    end

    def undent
      gsub(/^.{#{slice(/^ +/).length}}/, '')
    end
  end
end

class String
  [:word_wrap, :undent].each do |method|
    if instance_methods.include?(method)
      raise "Method '#{method}' exists. String Extensions will not override!"
    end
  end

  include Velomemo::String
end
