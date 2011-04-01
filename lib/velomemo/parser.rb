require 'yaml'

module Velomemo

  class Parser
    def self.parse(data)
      YAML::load(data).map { |entry| Ride.new(entry) }
    end
  end

end
