require 'redis'

class RedisConnections
    def initialize
        @num_conns = [nil,""].include?(ENV['REDIS_CONNS']) ? 500 : ENV['REDIS_CONNS'].to_i
        @redis_url = [nil,""].include?(ENV['REDIS_URL']) ? false : ENV['REDIS_URL']
        @threads = []
    end

    def fetch
        return if @redis_url == false
        0.upto(@num_conns) do |idx|
            @threads << Thread.new {
                r = Redis.new(url: @redis_url)
                r.set("thread#{idx}","thread_set")
                Thread.pass
                sleep(0.1)
                r.read("thread#{idx}")
                Thread.pass
                sleep(0.1)
                r.del("thread#{idx}")
            }
        end
    end 

    def status
        alive = 0
        @threads.each do |thr|
            alive += 1 if thr.alive?
        end
        return "#{alive} redis threads still running"
    end
end