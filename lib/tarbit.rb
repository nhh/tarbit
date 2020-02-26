# frozen_string_literal: true
#

require 'async/reactor'
require 'os'

require_relative 'tarbit/server'
require_relative 'tarbit/statistic_watcher'
require_relative 'tarbit/statistic_snapshot'
require_relative 'tarbit/version'

Signal.trap "SIGINT" do
  exit(0)
end

module Tarbit

  if OS.posix?
    if $stdout.isatty # If we are interactive, we can guess there is a home directory
      STATS_PATH = File.expand_path("~/.tarbit/statistics").to_s
      SNAPSHOT_PATH = File.expand_path("~/.tarbit/snapshots").to_s
    else
      STATS_PATH = "/etc/tarbit/statistics"
      SNAPSHOT_PATH = "/etc/tarbit/snapshots"
    end
  end

  if OS.windows?
    if $stdout.isatty # If we are interactive, we can guess there is a home directory
      STATS_PATH = File.expand_path("~/.tarbit/statistics").to_s
      SNAPSHOT_PATH = File.expand_path("~/.tarbit/snapshots").to_s
    else
      STATS_PATH = "/etc/tarbit/statistics"
      SNAPSHOT_PATH = "/etc/tarbit/snapshots"
    end
  end

end