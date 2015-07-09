require_relative 'cli'
require_relative 'version'
require_relative 'conductor/parsers/options_parser'
require_relative 'conductor/commands/command_factory'

include Conductor::CLI
include Conductor::Parsers
include Conductor::Commands
