require 'gruff'
require 'async'

module Tarbit
  class Statistic

    def initialize(server, interval)
      @server = server
      @interval = interval
      @history = []
    end

    def watch
      Async do |task|
        while true
          task.sleep @interval
          write_line_chart
        end
      end
    end

    private

    def write_line_chart
      return if @server.connections.size == 0 and @history.size == 0

      # Add point in time
      @history << {
          created_at: Date.new.strftime("%B %d, %Y"),
          connections: @server.connections.clone # Cloning instead of referencing
      }

      g = Gruff::Line.new
      g.title = 'History of connections over time'

      labels = {}
      @history.each_with_index{ |item, index| labels[index] = item.fetch(:created_at) }
      g.labels = labels

      g.data :Bots, @history.map {|point_in_time| point_in_time.fetch(:connections).size }

      g.write(File.expand_path ('~/.tarbit/stats/line_chart.png'))
    end

  end
end
