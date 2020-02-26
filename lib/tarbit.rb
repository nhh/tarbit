# frozen_string_literal: true
#

require 'async/reactor'
require_relative 'tarbit/server'
require_relative 'tarbit/statistic'

Signal.trap "SIGINT" do
  exit(0)
end

module Tarbit; end