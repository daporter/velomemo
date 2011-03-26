require 'optparse'
require 'ostruct'
require 'pp'

module Velomemo

  class CLI
    def self.execute(stdout, args=[])
      options = parse_options(stdout, args)

      # data = File.read(options.file)
      # entries = Velomemo::Parser.new(data).parse
      # stdout.puts Velomemo::Report.new(entries)

      stdout.puts "$: #{$:}"
    end

    def self.parse_options(stdout, args)
      options = OpenStruct.new

      opts = OptionParser.new
      opts.banner = "Usage: #{File.basename($0)} [options]"

      opts.on("-f", "--file FILE", "Read entries from FILE") do |file|
        options.file = file
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
