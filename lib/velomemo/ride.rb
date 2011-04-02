module Velomemo

  class Ride
    LABEL_WIDTH = 20
    LINE_WIDTH  = 78

    def initialize(data)
      @data = data
    end

    def to_s
      @data.map do |label, value|
        value_segments = word_wrap(value.to_s).lines.to_a
        s = sprintf("%#{LABEL_WIDTH}s: %s", label, value_segments[0])
        value_segments[1..-1].each do |value_segment|
          s << sprintf("%#{LABEL_WIDTH}s  %s", ' ', value_segment)
        end
        s
      end.join("\n")
    end

    private

    def word_wrap(text)
      length = LINE_WIDTH - LABEL_WIDTH - 2
      text.split("\n").collect do |line|
        if line.length > length
          line.gsub(/(.{1,#{length}})(\s+|$)/, "\\1\n").strip
        else
          line
        end
      end * "\n"
    end
  end

end
