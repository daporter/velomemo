module Velomemo

  class Report
    def initialize(rides, period=nil)
      @rides  = rides
      @period = period
    end

    def rides_in_period
      @period ? @rides.find_all { |r| @period.includes?(r.date) } : @rides
    end

    def to_s
      rides_in_period.map(&:to_s).join("\n")
    end
  end

end
