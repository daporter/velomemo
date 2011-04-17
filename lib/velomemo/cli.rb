require "trollop"

module Velomemo

  class CLI
    def self.execute(stdout, stderr, args=[])
      options = parse_options(args)
      data    = File.read(options[:file])
      period  = Period.new(options.begin, options.end)
      rides   = Velomemo::Parser.parse(data)

      stdout.puts Velomemo::Report.new(rides, period)
    end

    def self.parse_options(args)
      options = Trollop::options(args) do
        version "#{File.basename($0)} #{Velomemo::VERSION}"

        banner <<-EOS.undent
          Usage: #{File.basename($0)} [options]
        EOS

        opt :file,  "File containing ride data",     :type => ::String, :required => true
        opt :begin, "Ignore rides before this date", :type => Date
        opt :end,   "Ignore rides after this date",  :type => Date
      end

      Trollop::die :file, "must exist" unless File.exist?(options[:file])

      options
    end
  end

end
