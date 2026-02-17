# frozen_string_literal: true

require_relative 'lib/rubocop-monolith-idioms/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-monolith-idioms'
  spec.version       = RuboCop::MonolithIdioms::VERSION
  spec.authors       = ['NewAlexandria']
  spec.email         = ['nospam@newalexandria.org']

  spec.summary       = 'RuboCop cops for idiomatic Ruby and Rails monolith patterns'
  spec.description   = 'A RuboCop extension for idiomatic naming and Rails large-codebase patterns, ' \
                       'including get_/set_ method naming and future monolith-focused rules.'
  spec.homepage      = 'https://github.com/NewAlexandria/rubocop-monolith-idioms'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['documentation_uri'] = "#{spec.homepage}/tree/main/guides"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    files = if system('git rev-parse --git-dir > /dev/null 2>&1')
              `git ls-files -z`.split("\x0")
            else
              Dir['lib/**/*', 'config/**/*', 'guides/**/*', '*.md', 'LICENSE*'].reject { |f| File.directory?(f) }
            end
    files.reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile rubocop-core-integration/])
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'lint_roller', '~> 1.1'
  spec.add_dependency 'rubocop', '>= 1.0'

  spec.metadata['default_lint_roller_plugin'] = 'RuboCop::MonolithIdioms::Plugin'
end
