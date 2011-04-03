module Velomemo

  class Ride
    LABEL_WIDTH = 20
    LINE_WIDTH  = 78

    def initialize(data)
      @data = data
    end

    def to_s
      @data.map do |label, value|
        suffixes = word_wrap(value.to_s, LINE_WIDTH-LABEL_WIDTH-2).lines.to_a
        prefixes =  [sprintf("%#{LABEL_WIDTH}s: ", label)]
        prefixes << [" " * LABEL_WIDTH + "  "] * (suffixes.size - 1)
        prefixes.zip(suffixes).flatten.join
      end.join("\n")
    end

    private

    def word_wrap(text, length=80)
      text.split("\n").map do |line|
        if line.length > length
          line.gsub(/(.{1,#{length}})(\s+|$)/, "\\1\n").strip
        else
          line
        end
      end.join("\n")
    end
  end

end
