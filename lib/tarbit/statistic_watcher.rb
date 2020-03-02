require 'gruff'
require 'async'
require 'json'

module Tarbit
  class StatisticWatcher

    def initialize(server, interval)
      @server = server
      @interval = interval.nil? ? 1800 : interval.to_i
      Async.logger.info "SatisticWatcher - Starting watcher with interval #{@interval}"
    end

    def watch
      Async do |task|
        while true
          task.sleep @interval
          create_point_in_time
        end
      end
    end

    private

    def create_point_in_time
      # Add point in time
      statistic_point = {
          created_at: Time.new.strftime("%H:%M"),
          connections: @server.connections.clone
      }

      File.write("#{Tarbit::STATS_PATH}/#{statistic_point.fetch(:created_at)}.json", JSON.generate(statistic_point))

    end

  end
end
