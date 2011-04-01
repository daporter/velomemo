require 'yaml'

module Velomemo

  class Parser
    def self.parse(data)
      YAML::load(data)
    end
  end

end
