require File.dirname(__FILE__) + '/spec_helper'
require "velomemo/string_extensions"

describe "String extensions" do

  describe "#word_wrap" do
    describe "with width=4" do
      it "wraps 'foo'" do
        "foo".word_wrap(4).should == "foo\n"
      end

      it "wraps 'foo bar'" do
        "foo bar".word_wrap(4).should == "foo\nbar\n"
      end

      it "wraps 'f o bar'" do
        "f o bar".word_wrap(4).should == "f o\nbar\n"
      end

      it "wraps 'foo bar baz'" do
        "foo bar baz".word_wrap(4).should == "foo\nbar\nbaz\n"
      end

      it "wraps 'foobar baz'" do
        "foobar baz".word_wrap(4).should == "foobar\nbaz\n"
      end
    end
  end

end
