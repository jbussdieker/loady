module Loady
  class Args
    def self.parse
      args = {:url => ARGV[0]}
      args.merge!({:header => ARGV[1]}) if ARGV[1]
      args
    end
  end
end
