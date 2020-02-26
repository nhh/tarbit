# frozen_string_literal: true

require 'async/io'
require 'async/io/stream'
require 'async/reactor'
require 'async/io/host_endpoint'
require 'async/io/protocol/line'
require 'securerandom'

module Tarbit
  class Server
    attr_reader :connections

    def initialize
      @connections = []
    end

    def run
      endpoint = Async::IO::Endpoint.parse("tcp://localhost:1025")

      Async do |task|
        while true
          task.sleep 1
          Async.logger.info "Connection count: #{@connections.size}"
        end
      end

      Async do |task|
        endpoint.accept do |peer|
          stream = Async::IO::Stream.new(peer)
          Async.logger.info "New connection: #{stream}"

          @connections << {
              created_at: Date.new,
              id: SecureRandom.uuid
          }

          while true do
            task.sleep 1
            stream.write "#{rand(10)}\r\n"
          end
        rescue Async::TimeoutError => e
          @connections.delete stream
          Async.logger.info "Connection closed: #{stream}"
        end
      end
    end

  end

end