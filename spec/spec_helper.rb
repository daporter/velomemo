require "rspec/core"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require "velomemo"

module CLIMatchers
  def it_requires_an_argument_for_option(option)
    it "requires an argument for option '#{option}'" do
      expect do
        Velomemo::CLI.parse_options(STDOUT, [option])
      end.to raise_error(OptionParser::MissingArgument)
    end
  end

  def it_does_not_accept_option_argument(option)
    it "it does not accept option argument '#{option}'" do
      expect do
        Velomemo::CLI.parse_options(STDOUT, option.split)
      end.to raise_error(OptionParser::InvalidArgument)
    end
  end

  def it_accepts_option_argument(option)
    it "it accepts option argument '#{option}'" do
      expect do
        Velomemo::CLI.parse_options(STDOUT, option.split)
      end.to_not raise_error
    end
  end
end
