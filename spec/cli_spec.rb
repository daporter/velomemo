require File.dirname(__FILE__) + "/spec_helper"

describe Velomemo::CLI do
  extend CLIMatchers

  describe "#parse_options" do
    # Custom matchers are defined in spec/spec_helper.rb
    it_requires_an_argument_for_option "-b"
    it_does_not_accept_option_argument "-b foo"
    it_accepts_option_argument         "-b 2011-04-05"

    it_requires_an_argument_for_option "-e"
    it_does_not_accept_option_argument "-e foo"
    it_accepts_option_argument         "-e 2011-04-05"
  end
end
