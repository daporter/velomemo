require "trollop"

module Velomemo

  class CLI
    def self.execute(stdout, stderr, args=[])
      @stdout, @stderr = stdout, stderr

      options = parse_options(args)
      file    = options[:file] || ENV["VELOMEMO_FILE"]
      rides   = Velomemo::Parser.parse(read_data(file))
      period  = Period.new(options[:begin], options[:end])
      fields  = ARGV
      
      @stdout.puts Velomemo::Report.new(rides, period, fields)
    end

    def self.parse_options(args)
      $stdout, $stderr = @stdout, @stderr

      options = Trollop::options(args) do
        version "#{File.basename($0)} #{Velomemo::VERSION}"

        banner <<-EOS.undent
          Usage: #{File.basename($0)} [options]
        EOS

        opt :file,  "File containing ride data",     :type => ::String
        opt :begin, "Ignore rides before this date", :type => Date
        opt :end,   "Ignore rides after this date",  :type => Date
      end

      options
    end

    private

    def self.read_data(file)
      fail "Error: No journal file was specified" unless file
      File.read(file)
    rescue
      fail "Error: Cannot read journal file '#{file}'"
    end

    def self.fail(message)
      @stderr.puts message
      exit(-1)
    end
  end

end
