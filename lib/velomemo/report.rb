module Velomemo

  class Report
    def initialize(rides, period, fields)
      @rides, @period, @fields = rides, period, fields
    end

    def rides_in_period
      @rides.find_all { |r| @period.includes?(r.date) }
    end

    def to_s
      rides_in_period.map { |r| r.to_s(@fields) }.join("\n")
    end
  end

end
