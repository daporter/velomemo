module Velomemo

  class Period
    def initialize(b, e)
      if b && e && b > e
        raise ArgumentError, "Expected beginning <= end. Got #{b}, #{e}"
      end

      @beginning, @end = b, e
    end

    attr_reader :beginning, :end

    def includes?(date)
      return true               if date.nil?
      return true               if beginning.nil? && self.end.nil?
      return date <= self.end   if beginning.nil?
      return beginning <= date  if self.end.nil?

      beginning <= date && date <= self.end
    end
  end

end
