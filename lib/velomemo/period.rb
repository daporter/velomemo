module Velomemo

  class Period
    attr_reader :begin, :end

    def initialize(b, e)
      raise ArgumentError, "Expected begin <= end. Got #{b}, #{e}"  if b > e
      @begin, @end = b, e
    end

    def includes?(date)
      return true  if date.nil?
      @begin <= date && date <= @end
    end
  end

end
