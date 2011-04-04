module Velomemo

  class Report
    def initialize(rides)
      @rides = rides
    end

    def to_s
      @rides.map(&:to_s).join("\n")
    end
  end

end
