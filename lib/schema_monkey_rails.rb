require 'schema_monkey'

module SchemaMonkey
  module Rails
  end
end

require_relative 'schema_monkey_rails/version'
require_relative 'schema_monkey_rails/railtie' if defined?(::Rails::Railtie)
