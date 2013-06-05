module Loady
  class Command
    def initialize(args = {})
      @args = args
    end

    def ab(count, concurrency)
      site = @args[:url]
      if @args[:header]
        cmd = "ab -n #{count} -c #{concurrency} -H \"#{@args[:header]}\" #{site}"
      else
        cmd = "ab -n #{count} -c #{concurrency} #{site}"
      end
      data = `#{cmd}`
      results = Result.new(data)
      results
    end

    def run
      puts "Starting test..."
      concurrency = 1
      count = 5
      results = ab(count, concurrency)

      @plot_data = []

      while !results.errors? do
        @plot_data << "#{concurrency}\t#{results.rps}\t#{results.mean_total_time}\t#{results.ninty_five}"
        puts "#{concurrency}\t#{results.rps}\t#{results.mean_total_time}\t#{results.ninty_five}"

        if concurrency < 10
          concurrency += 1
        elsif concurrency < 100
          concurrency += 5
        else
          concurrency += 10
        end

        count = (5 * results.rps).to_i
        results = ab(count, concurrency)

        plot
      end
    end

    def plot
      File.open("data/plot_data", "w") {|f| f.write(@plot_data.join("\n"))}
      puts `gnuplot data/plot_script`
    end
  end
end
