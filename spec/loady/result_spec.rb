require 'loady/result'

describe Loady::Result do
  before do
    @result1 = Loady::Result.new(File.read("spec/loady/sample1.txt"))
    @result2 = Loady::Result.new(File.read("spec/loady/sample2.txt"))
  end

  it { @result1.rps.should eql(169.0) }
  it { @result2.rps.should eql(338.0) }
end
