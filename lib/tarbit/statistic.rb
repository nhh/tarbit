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

      # Add point in time
      @history << {
          created_at: Date.new.strftime("%B %d, %Y"),
          connections: @server.connections.clone
      }

      g = Gruff::Line.new
      g.title = 'History of connections over time'

      labels = {}
      @history.each_with_index{ |item, index| labels[index] = item.fetch(:created_at) }
      g.labels = labels

      g.data :Bots, @history.map {|point_in_time| point_in_time.fetch(:connections).size }

      g.write('data/exciting.png')
    end

  end
end
