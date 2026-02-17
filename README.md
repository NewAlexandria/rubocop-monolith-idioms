# RuboCop Monolith Idioms

Your monolith has opinions — put them in cops.

A RuboCop extension for teams running large Rails codebases who want idiomatic naming, boundary enforcement, and room to encode their own patterns as lint rules. Ships with a `get_`/`set_` method-naming cop out of the box and a scaffold for adding more. **Fork this repo, add your domain cops, and let the linter teach the codebase.**

**Departments:** [Naming](docs/RAILS_MONOLITH_SCOPE.md) (method naming; has cops today) · **RailsArchitecture** (boundaries, engines) · **RailsSafety** (dangerous patterns) · **RailsPerformance** (query/loading). See [Rails monolith scope](docs/RAILS_MONOLITH_SCOPE.md).

## Fork and add your patterns

Two paths:

1. **Use the gem as-is.** Install it, enable the built-in cops, move on.
2. **Fork this repo** and add cops for your domain. Run `bundle exec rake 'new_cop[Department/CopName]'`, follow [docs/ADDING_COPS.md](docs/ADDING_COPS.md), and ship rules that encode your team's idioms.

Building with AI agents? Install the [agent context doc](#install-agent-context) so your editor agent knows how to add new rules without asking.

## Quick start

Add the gem to your `Gemfile`:

```ruby
gem 'rubocop-monolith-idioms', require: false
```

Then run:

```bash
bundle install
```

Load via **plugin** (RuboCop 1.72+) or **require** (older versions):

```yaml
# .rubocop.yml — pick one
plugins:
  - rubocop-monolith-idioms   # RuboCop 1.72+

require:
  - rubocop-monolith-idioms   # older RuboCop
```

Run `rubocop` as usual — the cops load automatically.

## Install agent context

After `bundle install`, run:

```bash
bundle exec install-context
```

This creates an `AGENTS.md` file in your project root — a universal context doc that any AI agent or IDE can read. It tells agents what this gem does and how to add new cops so they can contribute rules without manual guidance.

If you prefer a different location (e.g., `.cursor/rubocop-monolith-idioms.md` for a Cursor-only setup), use `--path`:

```bash
bundle exec install-context --path .cursor/rubocop-monolith-idioms.md
```

By default, Naming/MethodNameGetPrefix examples (good, bad, and exception) are also copied into `docs/rubocop-monolith-idioms-examples/`. Use `--without-examples` to skip. Create that directory and add one markdown file per cop with Context and embedded code blocks so agents use this repo's examples when applying the rules.

See [bin/install-context](bin/install-context) for flags (`--force`, `--path`, `--without-examples`).

## What's in the box

This cop flags methods that:

- Start with `get_` prefix and take one or more arguments
- Start with `set_` prefix and take a _single_ required argument (without defaults)

For `get_` prefixed methods, it suggests renaming them to use more idiomatic Ruby patterns:

- `*_for` pattern (e.g., `get_user(id)` → `user_for(id)`)
- `find_*` pattern (e.g., `get_user(id)` → `find_user(id)`)

For `set_` prefixed methods with a single required argument:

- Regular methods: suggests using `=` method syntax (e.g., `set_user(val)` → `user=(val)`)
- API client methods: suggests `create_`, `put_`, or `update_` prefixes (e.g., `set_user(data)` → `create_user(data)`)

### Examples

**Bad - `get_` prefix:**

```ruby
def get_user(id)
  User.find(id)
end

def get_db_line_item(order_id, line_item_id)
  # ...
end
```

**Good - `get_` prefix:**

```ruby
def user_for(id)
  # some additional checks or logic ....
  SpecializedUserClass.find(id)
end

def db_line_item_for(order_id, line_item_id)
  # ...
end

# Or using find_ pattern
def find_user(id)
  SpecializedUserClass.find(id)
end
```

**Bad - `set_` prefix (single argument):**

```ruby
def set_custom_var(val)
  @custom_var = val
end
```

**Good - `set_` prefix (single argument):**

```ruby
def custom_var=(val)
  @custom_var = val
end
```

**Allowed - `set_` prefix (2+ arguments):**

```ruby
# Methods with 2+ required arguments are not flagged
# since the `=` suffix is only idiomatic for single-argument setters
def set_user(id, name)
  @user = User.new(id: id, name: name)
end
```

## Exclusions

The cop automatically excludes:

1. **Accessor methods** - Methods without arguments are handled by `Naming/AccessorMethodName`

   ```ruby
   def get_user
     @user
   end
   ```

2. **HTTP GET requests** - Methods that make HTTP GET requests are excluded:

   ```ruby
   def get_user(id)
     connection.get("/users/#{id}")
   end

   def get_checkout(id)
     request = Net::HTTP::Get.new(uri)
     http.request(request)
   end
   ```

3. **API client methods** - Methods in API client files that call `get()` are excluded:

   ```ruby
   # In a file matching *client*.rb, *api_client*.rb, *controller*.rb, etc.
   def get_user(id)
     get("/users/#{id}")
   end
   ```

4. **`set_` methods with 2+ required arguments** - Since the `=` suffix is only idiomatic for single-argument setters in Ruby:

   ```ruby
   # Not flagged - has 2+ required arguments
   def set_user(id, name)
     @user = User.new(id: id, name: name)
   end

   # Not flagged - has 2+ required keyword arguments
   def set_user(id:, name:)
     @user = User.new(id: id, name: name)
   end
   ```

## Auto-correction

The cop supports auto-correction. Run:

```bash
# Auto-correct a specific file
rubocop --autocorrect path/to/file.rb

# Auto-correct all files (with -A for unsafe corrections)
rubocop -A

# Auto-correct only this cop
rubocop --only Naming/MethodNameGetPrefix --autocorrect
```

**Note:** Auto-correction only renames method definitions, not call sites. After auto-correcting, you'll need to update any calls to the renamed method.

## Configuration

The cop can be configured in your `.rubocop.yml`:

```yaml
Naming/MethodNameGetPrefix:
  Enabled: true
```

## Cop documentation

Each cop has a dedicated guide with rationale, examples, and configuration options:

- [Naming/MethodNameGetPrefix](guides/naming-method-name-get-prefix.md)

## Rails large-codebase scope

This extension is targeted toward rules for large Rails codebases. See [docs/RAILS_MONOLITH_SCOPE.md](docs/RAILS_MONOLITH_SCOPE.md) for:

- Rule scope and future departments (Naming, RailsArchitecture, RailsSafety, RailsPerformance)
- Baseline vs strict profiles
- Migration strategy: audit first, then enforce

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rspec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

To add a new cop, use `bundle exec rake 'new_cop[Department/CopName]'` and follow [docs/ADDING_COPS.md](docs/ADDING_COPS.md).

## Contributing and sharing back

Upstream welcomes new cops or config that other monoliths could use. If you added something internal-only, that's fine — consider open-sourcing a redacted or generalized version.

PRs may receive automated Copilot code-review comments that nudge when a rule looks company-specific; those are nudges, not blockers.

See [CONTRIBUTING.md](CONTRIBUTING.md) for full details, including how to enable Copilot code review on your fork.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
