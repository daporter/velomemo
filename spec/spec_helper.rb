require "rspec/core"

require_relative "../lib/velomemo"

module CLIMatchers
  def it_requires_an_argument_for_option(option)
    subject { Velomemo::CLI }
    it "requires an argument for option '#{option}'" do
      expect do
        subject.parse_options(STDOUT, [option])
      end.to raise_error(OptionParser::MissingArgument)
    end
  end

  def it_does_not_accept_option_argument(option)
    subject { Velomemo::CLI }
    it "it does not accept option argument '#{option}'" do
      expect do
        subject.parse_options(STDOUT, option.split)
      end.to raise_error(OptionParser::InvalidArgument)
    end
  end

  def it_accepts_option_argument(option)
    subject { Velomemo::CLI }
    it "it accepts option argument '#{option}'" do
      expect { subject.parse_options(STDOUT, option.split) }.to_not raise_error
    end
  end
end
