require 'gruff'
require 'async'
require 'json'

module Tarbit
  class StatisticWatcher

    def initialize(server, interval = 600)
      @server = server
      @interval = interval.to_i
      @history = []
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
          created_at: Time.now.to_i,
          connections: @server.connections.clone
      }

      File.write("#{Tarbit::STATS_PATH}/#{statistic_point.fetch(:created_at)}.json", JSON.generate(statistic_point))

    end

  end
end
