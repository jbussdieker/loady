require 'loady/result'

describe Loady::Result do
  before do
    @result1 = Loady::Result.new(File.read("spec/loady/sample1.txt"))
    @result2 = Loady::Result.new(File.read("spec/loady/sample2.txt"))
  end

  it { @result1.rps.should eql(4166.67) }
  it { @result1.ninty_five.should eql(nil) }
  it { @result1.mean_total_time.should eql(44) }
  it { @result1.max_total_time.should eql(55) }
  it { @result1.errors?.should eql(false) }

  it { @result2.rps.should eql(3164.56) }
  it { @result2.ninty_five.should eql(123) }
  it { @result2.mean_total_time.should eql(33) }
  it { @result2.max_total_time.should eql(88) }
  it { @result2.errors?.should eql(false) }
end
