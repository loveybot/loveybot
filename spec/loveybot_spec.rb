require 'spec_helper'

describe Loveybot::Loveybot do
  it "believes in Truth" do
    true.should be_true
  end

  it "Gets a collection of gists on initialization" do
    lb = Loveybot::Loveybot.new
    lb.gists.first.should be_a Loveybot::Gist
  end
end
