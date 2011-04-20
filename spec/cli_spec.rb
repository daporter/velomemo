require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::CLI do
  subject { Velomemo::CLI }
  describe "#execute" do
    let(:stdout_s) { "" }
    let(:stdout)   { StringIO.new(stdout_s) }
    let(:stderr_s) { "" }
    let(:stderr)   { StringIO.new(stderr_s) }

    it { should require_an_argument_for_option("file") }
    it { should require_an_argument_for_option("begin") }
    it { should require_an_argument_for_option("end") }

    describe "with option 'version'" do
      it "displays the version number on stdout" do
        expect { subject.execute stdout, stderr, ["--version"] }.to exit_with_code(0)
        stdout_s.should =~ /#{Velomemo::VERSION}/
      end
    end

    describe "with option 'help'" do
      it "displays usage on stdout" do
        expect { subject.execute stdout, stderr, ["--help"] }.to exit_with_code(0)
        stdout_s.should =~ /^Usage: /
      end
    end

    describe "with option 'file'" do
      it "exits with error if the specified file doesn't exist" do
        expect { subject.execute stdout, stderr, ["--file", "missing"] }.to exit_with_code(-1)
        stderr_s.should =~ /must exist/
      end
    end
  end
end
