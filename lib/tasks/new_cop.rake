# frozen_string_literal: true

desc 'Generate a new cop. Usage: rake new_cop[Department/CopName]'
task :new_cop, [:cop] => [] do |_t, args|
  cop_arg = args[:cop]
  abort 'Usage: rake new_cop[Department/CopName]' if cop_arg.nil? || cop_arg.empty?

  abort 'Cop must be in Department/CopName format (e.g., Naming/ExampleCop)' unless cop_arg.include?('/')

  department, cop_name = cop_arg.split('/')
  department_module = department
  cop_class = cop_name
  file_name = cop_name.gsub(/([A-Z])/, '_\1').downcase.sub(/^_/, '')
  spec_file_name = "#{file_name}_spec"

  root = Pathname.new(__dir__).join('../..')
  cop_path = root.join('lib/rubocop/cop', department.downcase, "#{file_name}.rb")
  spec_path = root.join('spec/rubocop/cop', department.downcase, "#{spec_file_name}.rb")
  manifest_path = root.join('lib/rubocop/cop', "#{department.downcase}_cops.rb")
  config_path = root.join('config/default.yml')
  guide_path = root.join('guides', "#{department.downcase}-#{file_name}.md")

  abort "Cop already exists: #{cop_path}" if cop_path.exist?

  FileUtils.mkdir_p(cop_path.dirname)
  FileUtils.mkdir_p(spec_path.dirname)

  cop_content = <<~RUBY
    # frozen_string_literal: true

    module RuboCop
      module Cop
        module #{department_module}
          # TODO: Add description.
          #
          # @example
          #   # bad
          #   bad_example
          #
          # @example
          #   # good
          #   good_example
          class #{cop_class} < Base
            MSG = 'TODO: Add message.'

            def on_def(node)
              # TODO: Implement detection
            end
          end
        end
      end
    end
  RUBY

  spec_content = <<~SPEC
    # frozen_string_literal: true

    require 'spec_helper'
    require 'rubocop/cop/#{department.downcase}/#{file_name}'

    RSpec.describe RuboCop::Cop::#{department_module}::#{cop_class}, :config do
      context 'when offense is present' do
        it 'registers an offense' do
          expect_offense(<<~RUBY)
            def bad_example
            ^^^^^^^^^^^^^^ TODO: Add message.
            end
          RUBY
        end
      end

      context 'when no offense' do
        it 'does not register an offense' do
          expect_no_offenses(<<~RUBY)
            def good_example
            end
          RUBY
        end
      end
    end
  SPEC

  guide_content = <<~MD
    # #{department}/#{cop_class}

    ## Rule Details

    TODO: Add rule description.

    ## Examples

    ### Incorrect code for this rule

    ```ruby
    # TODO
    ```

    ### Correct code for this rule

    ```ruby
    # TODO
    ```

    ## Configuration

    ```yaml
    #{department}/#{cop_class}:
      Enabled: true
    ```
  MD

  File.write(cop_path, cop_content)
  File.write(spec_path, spec_content)
  File.write(guide_path, guide_content)

  # Update or create manifest
  new_require = "require_relative '#{department.downcase}/#{file_name}'"
  if manifest_path.exist?
    manifest_content = File.read(manifest_path)
    unless manifest_content.include?(new_require)
      manifest_content = manifest_content.sub(
        /(require_relative.*\n)+/m,
        "\\0#{new_require}\n"
      )
      File.write(manifest_path, manifest_content)
    end
  else
    File.write(manifest_path, "# frozen_string_literal: true\n\n#{new_require}\n")
  end

  # Update config
  config_entry = <<~YAML

    #{department}/#{cop_class}:
      Description: 'TODO: Add description.'
      Enabled: false
      VersionAdded: '0.1.0'
  YAML
  File.open(config_path, 'a') { |f| f.write(config_entry) }

  puts 'Created:'
  puts "  #{cop_path}"
  puts "  #{spec_path}"
  puts "  #{guide_path}"
  puts "Updated: #{manifest_path}, #{config_path}"
  puts ''
  puts 'Next steps:'
  puts "  1. Implement the cop logic in #{cop_path}"
  puts "  2. Add specs and run: bundle exec rspec #{spec_path}"
  puts "  3. Update the guide at #{guide_path}"
  puts '  4. Add changelog entry'
end
