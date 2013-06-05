module Loady
  class Result
    def initialize(data)
      @data = data.split("\n")
    end

    def errors?
      begin
        return true if @data.length < 32
        @data[17].match(/\d+/)[0].to_i != 0
      rescue Exception => e
        p e
        p @data[17]
      end
    end

    def max_time
      @data[31]
    end

    def avg_time
      @data[31]
    end

    def min_time
      @data[31]
    end

    def ninty_five
      begin
        @data[39].split(" ").last
      rescue
        0
      end
      #@data[39]
    end

    def rps
      begin
        @data[21].match(/[\d\.]+/)[0].to_f
      rescue Exception => e
        p e
        p @data[21]
      end
    end

    def to_s
      @data.to_s
    end
  end
end
