require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::CLI do
  subject { Velomemo::CLI }
  describe "#execute" do
    let(:stdout_s) { "" }
    let(:stdout)   { StringIO.new(stdout_s) }
    let(:stderr_s) { "" }
    let(:stderr)   { StringIO.new(stderr_s) }

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

    describe "without option 'file'" do
      it "exits with error when VELOMEMO_FILE is not set" do
        ENV["VELOMEMO_FILE"] = nil
        expect { subject.execute stdout, stderr, [] }.to exit_with_code(-1)
        stderr_s.should =~ /^Error: No journal file was specified/
      end

      it "exits with error when file specified by VELOMEMO_FILE does not exist" do
        ENV["VELOMEMO_FILE"] = "missing"
        expect { subject.execute stdout, stderr, [] }.to exit_with_code(-1)
        stderr_s.should =~ /^Error: Cannot read journal file 'missing'/
      end
    end

    describe "with option 'file'" do
      it { should require_an_argument_for_option("file") }

      it "exits with error when file specified by arg does not exist" do
        expect { subject.execute stdout, stderr, ["-f", "missing"] }.to exit_with_code(-1)
        stderr_s.should =~ /^Error: Cannot read journal file 'missing'/
      end
    end
  end
end
