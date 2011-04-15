module Velomemo

  class Report
    def initialize(rides, period)
      @rides, @period = rides, period
    end

    def rides_in_period
      @rides.find_all { |r| @period.includes?(r.date) }
    end

    def to_s
      rides_in_period.map(&:to_s).join("\n")
    end
  end

end
