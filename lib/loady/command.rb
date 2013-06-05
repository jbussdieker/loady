module Loady
  class Command
    def initialize(args = {})
      @args = args
    end

    def run
      site = @args[:url]
      puts "Starting test..."
      concurrency = 1
      count = 1
      data = `ab -n #{count} -c #{concurrency} #{site}`
      results = Result.new(data)

      plot_data = []

      while !results.errors? do
        plot_data << "#{concurrency}\t#{results.rps}\t#{results.mean_total_time}\t#{results.ninty_five}"
        puts "#{concurrency}\t#{results.rps}\t#{results.mean_total_time}\t#{results.ninty_five}"

        if concurrency < 10
          concurrency += 1
        elsif concurrency < 100
          concurrency += 5
        else
          concurrency += 10
        end

        count = (5 * results.rps).to_i
        data = `ab -n #{count} -c #{concurrency} #{site}`
        results = Result.new(data)
      end

      File.open("data/plot_data", "w") {|f| f.write(plot_data.join("\n"))}

      puts `gnuplot data/plot_script`
    end
  end
end
