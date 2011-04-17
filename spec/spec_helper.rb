require "rspec/core"
require "rspec/expectations"

require_relative "../lib/velomemo"

module Velomemo

  module CLIMatchers
    def it_requires_an_argument_for_option(option)
      subject { Velomemo::CLI }
      it "requires an argument for option '#{option}'" do
        expect do
          subject.parse_options(StringIO.new, StringIO.new, [option])
        end.to exit_with_code(1)
      end
    end

    def it_does_not_accept_option_argument(option)
      subject { Velomemo::CLI }
      it "it does not accept option argument '#{option}'" do
        expect do
          subject.parse_options(StringIO.new, StringIO.new, option.split)
        end.to exit_with_code(1)
      end
    end

    def it_accepts_option_argument(option)
      subject { Velomemo::CLI }
      it "it accepts option argument '#{option}'" do
        expect do
          subject.parse_options(StringIO.new, StringIO.new, option.split)
        end.to_not raise_error
      end
    end
  end

  module ExitCodeMatchers
    RSpec::Matchers.define :exit_with_code do |expected|
      match do |block|
        begin
          block.call
        rescue SystemExit => e
          actual = e.status
        end
        actual && actual == expected
      end

      failure_message_for_should do |block|
        "expected block to call exit(#{expected}) but exit" +
          (actual.nil? ? " not called" : "(#{actual}) was called")
      end

      failure_message_for_should_not do |block|
        "expected block not to call exit(#{expected})"
      end

      description do
        "expect block to call exit(#{expected})"
      end
    end
  end

end
