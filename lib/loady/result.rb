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

    def total_times
      field = find_field("Total:")
      field.split(" ")
    end

    def max_total_time
      total_times[5].to_i
    end

    def mean_total_time
      total_times[2].to_i
    end

    def ninty_five
      field = find_field("  95%")
      field.split(" ").last.to_i if field
    end

    def rps
      field = find_field("Requests per second:")
      field.match(/[\d\.]+/)[0].to_f
    end

    def to_s
      @data.to_s
    end

    def find_field(name)
      @data.each do |item|
        if item.start_with? name
          return item
        end
      end
      nil
    end
  end
end
