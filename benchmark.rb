require "faraday"
require "typhoeus"
require "typhoeus/adapters/faraday"
require "rack"
require "thin"
require "benchmark"

class HelloWorld
  def call(env)
    [ 200, { "Content-Type" => "text/plain" }, ["Hello World"] ]
  end
end

Thread.new { Rack::Handler::Thin.run HelloWorld.new }
sleep 1

def report(benchmark, adapter)
  conn = Faraday.new("http://localhost:8080") do |c|
    c.adapter adapter
  end
  benchmark.report(adapter) do
    500.times { conn.get }
  end
  conn.close
end

def benchmark(adapters)
  Benchmark.bm do |benchmark|
    adapters.each { |adapter| report benchmark, adapter }
  end
end

benchmark [:net_http, :typhoeus]
benchmark [:typhoeus, :net_http]
benchmark [:net_http, :typhoeus, :net_http, :typhoeus, :net_http, :typhoeus]