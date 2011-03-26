module Velomemo

  class Report
    def initialize(entries)
      @entries = entries
    end

    def to_s
      @entries.join("\n")
    end
  end

end
