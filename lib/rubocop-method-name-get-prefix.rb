# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop-method-name-get-prefix/version'
require_relative 'rubocop/method_name_get_prefix/plugin'

Dir[File.join(__dir__, 'rubocop/cop/*_cops.rb')].sort.each { |f| require f }
