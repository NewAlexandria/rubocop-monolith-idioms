# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop-monolith-idioms/version'
require_relative 'rubocop/monolith_idioms/plugin'

Dir[File.join(__dir__, 'rubocop/cop/*_cops.rb')].sort.each { |f| require f }
