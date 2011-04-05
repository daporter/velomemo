require 'optparse'
require 'optparse/date'
require 'ostruct'

module Velomemo

  class CLI
    def self.execute(stdout, args=[])
      options = parse_options(stdout, args)
      data    = File.read(options.file)
      rides   = Velomemo::Parser.parse(data)

      stdout.puts Velomemo::Report.new(rides)
    end

    def self.parse_options(stdout, args)
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

      opts.parse!(args)
      options
    end
  end

end
