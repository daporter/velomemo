require 'optparse'
require 'optparse/date'
require 'ostruct'

module Velomemo

  class CLI
    def self.execute(stdout, stderr, args=[])
      options = parse_options(stdout, stderr, args)
      data    = File.read(options.file)
      period  = Period.new(options.begin, options.end)
      rides   = Velomemo::Parser.parse(data)

      stdout.puts Velomemo::Report.new(rides, period)
    end

    def self.parse_options(stdout, stderr, args)
      options = OpenStruct.new

      opts = OptionParser.new
      opts.banner = "Usage: #{File.basename($0)} [options]"

      opts.on("-b", "--begin DATE",
              Date,
              "Filter entries on or after DATE") do |b|
        options.begin = b
      end

      opts.on("-e", "--end DATE",
              Date,
              "Filter entries before or on DATE") do |e|
        options.end = e
      end

      opts.on("-f", "--file FILE", "Read entries from FILE") do |f|
        options.file = f
      end

      opts.on_tail("-h", "--help", "Show this message") do
        stdout.puts opts
        exit
      end

      opts.on_tail("--version", "Show version") do
        stdout.puts "#{File.basename($0)} #{Velomemo::VERSION}"
        exit
      end

      begin
        opts.parse!(args)
      rescue OptionParser::InvalidArgument, OptionParser::MissingArgument => e
        abort "Error: #{e.message}"
      end

      options
    end
  end

end
