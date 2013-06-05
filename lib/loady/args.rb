module Loady
  class Args
    def self.parse
      {:url => ARGV[0]}
    end
  end
end
