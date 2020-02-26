require 'gruff'
require 'async'
require 'json'

module Tarbit
  class StatisticSnapshot

    def initialize

    end

    def snapshot
      Async do
        write_line_chart
      end
    end

    private

    def write_line_chart
      files = Dir.glob(File.join(Tarbit::STATS_PATH, '*.json'))

      files = files.map { |filename| JSON.parse(File.read(filename)) }

      g = Gruff::Line.new
      g.title = 'History of connections over time'

      labels = {}
      files.each_with_index{ |item, index| labels[index] = item.fetch("created_at") }
      g.labels = labels

      g.data :Bots, files.map {|point_in_time| point_in_time.fetch("connections").size }

      filename = "#{Time.now.to_i}.png"
      g.write(File.join(Tarbit::SNAPSHOT_PATH, filename))

      Async.logger.info "Snapshot saved in: #{Tarbit::SNAPSHOT_PATH}/#{filename}"
    end

  end
end
