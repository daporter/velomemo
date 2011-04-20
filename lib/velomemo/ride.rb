require_relative "string_extensions"

module Velomemo

  class Ride
    def initialize(data, line_width=78)
      @data, @line_width = data, line_width
    end

    def date
      @data["date"]
    end

    def to_s(fields_to_display=[])
      filter_data(fields_to_display).map do |label, value|
        suffixes = wrap_and_split_lines(value)
        prefixes = label_and_blanks(label, suffixes.size)
        prefixes.zip(suffixes).flatten.join
      end.join
    end

    private

    def filter_data(fields)
      if fields.any?
        fields << "date" << "notes"   # always include date and notes
        @data.select { |label, _| fields.include?(label) }
      else
        @data
      end
    end

    def wrap_and_split_lines(value)
      value.to_s.word_wrap(value_width).lines.to_a
    end

    def value_width
      @line_width - label_width - 2
    end

    def label_width
      (0.25 * @line_width).to_i + 1
    end

    def label_and_blanks(label, n)
      [formatted_label(label)] + [blank_label] * (n-1)
    end

    def formatted_label(label)
      sprintf("%#{label_width}s: ", label)
    end

    def blank_label
      " " * label_width + "  "
    end
  end

end
