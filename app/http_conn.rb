require 'faraday'
class  HTTPConnections
    def initialize
        @num_conns = [nil,""].include?(ENV['HTTP_CONNS']) ? 500 : ENV['HTTP_CONNS'].to_i
        @http_off = [nil,""].include?(ENV['HTTP_OFF']) ? false : true
        @domains = File.readlines('top500Domains.txt', chomp: true)
        @threads = []
    end

    def fetch
        return if @http_off
        puts "num_conns #{@num_conns}"
        0.upto(@num_conns) do |count|
            idx = count % 500
            url = "https://#{@domains[idx]}"
            @threads << Thread.new {
                result = Faraday.get(url)
                Thread.exit
            }
        end
    end

    def status
        alive = 0
        @threads.each do |thr|
            alive += 1 if thr.alive?
        end
        return "#{alive} http threads still running"
    end
end