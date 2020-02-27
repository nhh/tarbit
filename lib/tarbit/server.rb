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

    def initialize(port)
      @connections = []
      @port = port.nil? ? 22 : port.to_i
      Async.logger.info "Server - Starting tarbit on port #{@port}"
    end

    def run
      endpoint = Async::IO::Endpoint.parse("tcp://0.0.0.0:#{@port}")

      Async do |task|
        endpoint.accept do |peer|
          stream = Async::IO::Stream.new(peer)
          Async.logger.info "New connection: #{stream}"

          id = SecureRandom.uuid

          @connections << {
              created_at: Date.new,
              id: id
          }

          while true do
            task.sleep 60
            if stream.eof? || stream.closed? || stream.io.closed? # Todo validate if flush is the problem here
              raise Async::TimeoutError.new
            end
            stream.write "#{rand(10)}\r\n"
            #stream.flush
          end
        rescue StandardError => e
          @connections = @connections.reject { |stats| stats.fetch(:id) == id }
          Async.logger.info "Connection closed: #{stream}"
        end
      end
    end

  end

end