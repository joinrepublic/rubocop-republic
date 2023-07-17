# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/republic'
require_relative 'rubocop/republic/version'
require_relative 'rubocop/republic/inject'

RuboCop::Republic::Inject.defaults!

require_relative 'rubocop/cop/republic_cops'
