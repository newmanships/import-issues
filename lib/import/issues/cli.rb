# frozen_string_literal: true

require 'thor'

module Import
  module Issues
    # Handle the application command line parsing
    # and the dispatch to various command objects
    #
    # @api public
    class CLI < Thor
      # Error raised by this runner
      Error = Class.new(StandardError)

      desc 'version', 'import-issues version'
      def version
        require_relative 'version'
        puts "v#{Import::Issues::VERSION}"
      end
      map %w(--version -v) => :version

      desc 'import', 'Imports cards from Trello into GitHub as issues'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def import(*)
        if options[:help]
          invoke :help, ['import']
        else
          require_relative 'commands/import'
          Import::Issues::Commands::Import.new(options).execute
        end
      end
    end
  end
end
