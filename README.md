# rubocop-method-name-get-prefix

A RuboCop extension that flags methods with `get_` or `set_` prefixes that take arguments, suggesting more idiomatic Ruby naming conventions.

## Installation

Add this gem to your Gemfile:

```ruby
gem 'rubocop-method-name-get-prefix', require: false
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install rubocop-method-name-get-prefix
```

## Usage

### Plugin loading (RuboCop 1.72+)

Add this to your `.rubocop.yml`:

```yaml
plugins:
  - rubocop-method-name-get-prefix
```

### Legacy require loading

For RuboCop versions before 1.72, use `require` instead:

```yaml
require:
  - rubocop-method-name-get-prefix
```

Or load via the command line:

```bash
rubocop --require rubocop-method-name-get-prefix
# or
rubocop --plugin rubocop-method-name-get-prefix
```

Now you can run `rubocop` and it will automatically load the cops.

## What it does

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/NewAlexandria/rubocop-method-name-get-prefix.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
