module Velomemo

  class Period
    attr_reader :beginning, :end

    def initialize(b, e)
      if b && e && b > e
        raise ArgumentError, "Expected beginning <= end. Got #{b}, #{e}"
      end

      @beginning, @end = b, e
    end

    def includes?(date)
      return true                if date.nil?
      return true                if @beginning.nil? && @end.nil?
      return date <= @end        if @beginning.nil?
      return @beginning <= date  if @end.nil?

      @beginning <= date && date <= @end
    end
  end

end
