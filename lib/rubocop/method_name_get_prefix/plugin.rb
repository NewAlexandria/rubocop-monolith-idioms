# frozen_string_literal: true

require 'pathname'
require 'lint_roller'

module RuboCop
  module MethodNameGetPrefix
    # A plugin that integrates this extension with RuboCop's plugin system (1.72+).
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: 'rubocop-method-name-get-prefix',
          version: VERSION,
          homepage: 'https://github.com/NewAlexandria/rubocop-method-name-get-prefix',
          description: 'RuboCop cops for idiomatic Ruby naming and Rails large-codebase patterns.'
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join('../../../config/default.yml')
        )
      end
    end
  end
end
