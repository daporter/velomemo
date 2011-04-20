require "rspec/core"
require "rspec/expectations"

require_relative "../lib/velomemo"

module Velomemo
  RSpec::Matchers.define(:require_an_argument_for_option) do |expected|
    match do |thing|
      stdout_s, stderr_s = "", ""
      stdout,   stderr   = StringIO.new(stdout_s), StringIO.new(stderr_s)
      begin
        thing.execute stdout, stderr, ["--#{expected}"]
      rescue SystemExit => e
        status = e.status
      end
      status == -1 && stderr_s =~ /^Error: /
    end

    description do
      "require an argument for option '#{expected}'"
    end

    failure_message_for_should do
      "expected option '#{expected}' to require an argument"
    end

    failure_message_for_should_not do
      "expected option '#{expected}' to not require an argument"
    end
  end

  RSpec::Matchers.define(:exit_with_code) do |expected|
    match do |block|
      begin
        block.call
      rescue SystemExit => e
        actual = e.status
      end
      actual and actual == expected
    end

    description do
      "expect block to call exit(#{expected})"
    end

    failure_message_for_should do |block|
      "expected block to call exit(#{expected}) but exit" +
        (actual.nil? ? " not called" : "(#{actual}) was called")
    end

    failure_message_for_should_not do |block|
      "expected block not to call exit(#{expected})"
    end
  end
end
