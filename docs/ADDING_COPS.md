# Adding New Cops

This document describes the repeatable process for adding new cops to this extension.

## Checklist

1. [ ] Create the cop file
2. [ ] Add cop to department manifest
3. [ ] Add config to `config/default.yml`
4. [ ] Write specs
5. [ ] Add guide in `guides/`
6. [ ] Add changelog entry

## 1. Create the cop file

Place the cop in `lib/rubocop/cop/<department>/<cop_name>.rb` using snake_case for the filename.

**Template structure:**

```ruby
# frozen_string_literal: true

module RuboCop
  module Cop
    module DepartmentName
      # Brief description of what the cop checks.
      #
      # @example
      #   # bad
      #   def bad_example
      #   end
      #
      # @example
      #   # good
      #   def good_example
      #   end
      class CopName < Base
        extend AutoCorrector  # if autocorrect is supported

        MSG = 'Clear, actionable message.'

        # Optional: restrict callback to specific method names for performance
        # RESTRICT_ON_SEND = [:method_name].freeze

        def on_def(node)  # or on_send, on_class, etc.
          return unless offense?(node)
          add_offense(node, message: MSG) do |corrector|
            # autocorrect logic if supported
          end
        end

        private

        def offense?(node)
          # detection logic
        end
      end
    end
  end
end
```

## 2. Add cop to department manifest

Edit `lib/rubocop/cop/<department>_cops.rb` and add:

```ruby
require_relative 'department/cop_name'
```

**New department:** Create `lib/rubocop/cop/<department>_cops.rb`; department manifests are auto-loaded.

## 3. Add config to config/default.yml

```yaml
Department/CopName:
  Description: 'Brief description for config.'
  Enabled: true
  VersionAdded: '0.x.0'
```

Use `Enabled: false` for cops that are opt-in or experimental.

## 4. Write specs

Create `spec/rubocop/cop/department/cop_name_spec.rb`:

```ruby
# frozen_string_literal: true

require 'spec_helper'
require 'rubocop/cop/department/cop_name'

RSpec.describe RuboCop::Cop::Department::CopName, :config do
  context 'when offense is present' do
    it 'registers an offense' do
      expect_offense(<<~RUBY)
        def bad_example
        ^^^^^^^^^^^^^^ Clear, actionable message.
        end
      RUBY
    end

    it 'autocorrects' do
      new_source = autocorrect_source(<<~RUBY)
        def bad_example
        end
      RUBY
      expect(new_source).to eq(<<~RUBY)
        def good_example
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
```

Use `expect_no_offenses(<<~RUBY, 'path/to/file.rb')` when testing file-path-dependent behavior.

## 5. Add guide in guides/

Create `guides/department-cop-name.md` following the format of [guides/naming-method-name-get-prefix.md](naming-method-name-get-prefix.md):

- Rule Details
- Rationale
- Examples (incorrect / correct)
- Exclusions
- Configuration

## 6. Add changelog entry

Add an entry to `CHANGELOG.md` under `## [Unreleased]`:

```markdown
### New cops

- **[Department/CopName]** New cop that does X. ([#PR])
```

Or for changes to existing cops:

```markdown
### Changes

- **[Department/CopName]** Fix/improve X. ([#PR])
```

## Running the new cop

```bash
bundle exec rubocop --only Department/CopName path/
bundle exec rspec spec/rubocop/cop/department/cop_name_spec.rb
```

## Rake task

Generate a new cop scaffold:

```bash
bundle exec rake new_cop[Department/CopName]
```

This creates the cop file, spec file, and updates the manifest and config. You still need to implement the logic, add the guide, and update the changelog.
