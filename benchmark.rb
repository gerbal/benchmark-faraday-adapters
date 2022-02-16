require 'benchmark'
require 'faraday'
require 'faraday/adapter/http'
require 'faraday/em_http'
require 'faraday/em_synchrony'
require 'faraday/excon'
require 'faraday/http'
require 'faraday/httpclient'
require 'httpx/adapters/faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
include Benchmark

HOST = 'http://localhost:8080'

def report(benchmark, adapter)
  conn = Faraday.new(HOST) do |c|
    c.adapter adapter
  end
  bm = benchmark.report(adapter) do
    500.times { conn.get }
  end
  conn.close

  bm
end

def benchmark(adapters)
  Benchmark.benchmark(CAPTION, 20, FORMAT) do |benchmark|
    adapters.each { |adapter| report benchmark, adapter }
  end
end

benchmark %i[
  em_http
  em_synchrony
  excon
  http
  httpclient
  httpx
  net_http
  net_http_persistent
  patron
  typhoeus
]
