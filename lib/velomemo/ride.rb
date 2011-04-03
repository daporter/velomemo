require "velomemo/word_wrap"

module Velomemo

  class Ride
    LABEL_WIDTH = 20
    LINE_WIDTH  = 78

    def initialize(data)
      @data = data
    end

    def to_s
      String.send :include, WordWrap

      @data.map do |label, value|
        suffixes = value.to_s.wrap(LINE_WIDTH - LABEL_WIDTH - 2).lines.to_a
        prefixes =  [sprintf("%#{LABEL_WIDTH}s: ", label)]
        prefixes << [" " * LABEL_WIDTH + "  "] * (suffixes.size - 1)
        prefixes.zip(suffixes).flatten.join
      end.join("\n")
    end
  end

end
